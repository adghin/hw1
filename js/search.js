/** Funzione che fa la fetch all'API di GBooks **/
function searchBook(event) {
	event.preventDefault();

	const loading = document.createElement('img');
	loading.src = 'css/loading.gif';
	loading.classList.add('loading');
	results_container.innerHTML = '';
	results_container.appendChild(loading);

	const query = encodeURIComponent(content.value);
	const url = "http://localhost/hw1/php/search_book.php?q=" + query; 
	fetch(url).then(onResponse).then(onJSON);
}

function onResponse(response) {
	return response.json();
}

/** La promise che permette di vedere i libri tornato dall'API **/
function onJSON(json) {
	results_container.innerHTML = '';
	results_container.classList.remove('hidden');

	for(const item of json.items) {
		let url = item.volumeInfo.imageLinks;
		if(url !== undefined) {
			url = item.volumeInfo.imageLinks.thumbnail;
			const book_id = item.id;
			const title = item.volumeInfo.title;
			const author = item.volumeInfo.authors;
			const description = item.volumeInfo.description;
		    
			appendHTML(url,book_id,title,author,description);
		}
	}

	const button_list = document.querySelectorAll('#addToLib');
	for(item of button_list) 
		item.addEventListener('click',showLibraries);
}

/** Funzione che chiama isPresent(from_target), che a sua volta controlla se il libro è già presente **/
function showLibraries(event) {
	event.preventDefault();
	
	const parent = event.currentTarget.parentNode.parentNode;
	parent.querySelector('form').classList.add('hidden');
	event.currentTarget.classList.add('hidden');

	const this_clicked = event.currentTarget;

	const div_options = document.createElement('div');
	div_options.classList.add('div-options');

	const close = document.createElement('span');
	close.classList.add('closeOptions');

	div_options.appendChild(close);

	parent.appendChild(div_options);
	
	const target = parent;	//prendo il parent più esterno (quindi non il form) del bottone 'Aggiungi ad una libreria +' 
	isPresent(target);

	close.addEventListener('click',(event) => {
		parent.removeChild(div_options);
		parent.querySelector('form').classList.remove('hidden');
		this_clicked.classList.remove('hidden');
	});
}

/** Funzione che controlla se il libro è già presente tramite una fetch **/
function isPresent(from_target) {
	const url = "http://localhost/hw1/php/already_added.php";

	fetch(url+"?q="+encodeURIComponent(from_target.parentNode.dataset.bookId)).then(onResponse).then((json) => {
		/** Promise che chiama getLibraries() se il libro non è presente, altrimenti mostra un warning **/
		if(json.present == false) {
			getLibraries(from_target);
		}
		if(json.present == true) {
			const p = document.createElement('p');
			p.textContent = "Hai già aggiunto questo libro ad una delle tue librerie!";

			from_target.querySelector('.div-options .closeOptions').classList.add('hidden');
			from_target.querySelector('.div-options').classList.add('warning');
			from_target.querySelector('.div-options').appendChild(p);
		}
	});
}

/** Funziona che permette di avere le librerie dell'utente tramite una fetch **/
/** In questa funzione così come in isPresent, abbiamo sfruttato la creazione di una closure per potere passare il parametro 
	from_target dalla funzione più esterna (outer function) a quella più interna (inner function); il motivo per cui abbiamo cambiato
	il codice di prima, levando la variabile globale target, è dettato dal fatto che in tal modo vi era un'alta possibilità di 
	race condition, poiché le variabili globali, essendo accessibili dall'esterno, possono essere cambiate da ogni parte del codice,
	compromettendo dunque il risultato al quale le promise avrebbero avuto accesso **/
function getLibraries(from_target) {
	const url = "http://localhost/hw1/php/get_libraries.php";

	fetch(url).then(onResponse).then((json) => {
			/** La promise che permette di vedere le librerie qualora il libro non fosse già presente **/
			if(json == null) {
				const span = document.createElement('span');
				span.textContent = "Nessuna libreria presente!";
				span.classList.add('libs');
				span.setAttribute("id","nolib")

				from_target.querySelector('.div-options').appendChild(span);

				const new_lib = document.createElement('span');
				new_lib.textContent = "Crea libreria";
				new_lib.classList.add('libs');
				new_lib.classList.add('create');
				new_lib.dataset.fromTarget = "explore";
				from_target.querySelector('.div-options').appendChild(new_lib);

				new_lib.addEventListener('click',addLibrary);
			}
			else {
				for(item of json) {
					const a = document.createElement('a');
					a.classList.add('libs');
					a.setAttribute("id",item.id);
					a.textContent = item.name;

					from_target.querySelector('.div-options').appendChild(a);
				}
				
				for(item of from_target.querySelectorAll('.div-options a')) {
					item.addEventListener('click',addBook);
				}

				const new_lib = document.createElement('span');
				new_lib.textContent = "Crea libreria";
				new_lib.classList.add('libs');
				new_lib.classList.add('create');
				new_lib.dataset.fromTarget = "explore";
				from_target.querySelector('.div-options').appendChild(new_lib);


				new_lib.addEventListener('click',addLibrary);
			}
	});
}

/** Funzione che effettua il salvataggio nel DB tramite una fetch **/
function addBook(event) {
	event.preventDefault();
	const article = event.currentTarget.parentNode.parentNode.parentNode;

	const data = new FormData();
	data.append("id",article.dataset.bookId);
	data.append("title",article.dataset.bookTitle);
	data.append("author",article.dataset.bookAuthor);
	data.append("cover",article.dataset.bookCover);
	data.append("lib_id",event.currentTarget.id);

	
	const url = "http://localhost/hw1/php/add_book.php";
	fetch(url,
			{
				method: 'POST',
				body: data 
			}
	).then(onResponse).then((json) => {
		/** Promise che mostra salvataggio avvenuto con succcesso! **/
		if(json.added_to_lib == true) {
			document.querySelector('.div-options .closeOptions').classList.add('hidden');
			article.querySelector('.div-options').innerHTML = '';
			const p = document.createElement('p');
			p.textContent = "Libro aggiunto con successo!";

			article.querySelector('.div-options').classList.add('saved');
			article.querySelector('.div-options').appendChild(p);
		}
		if(json.added_to_lib == false) { /* in caso di errore durante il salvataggio */
			const p = document.createElement('p');
			p.textContent = "C'è stato un errore durante il salvataggio!";

			article.querySelector('.div-options').classList.add('warning');
			article.querySelector('.div-options').appendChild(p);
		}
	});
}

/** Flusso al click sui button +:
	1. showLibraries();
	2. isPresent(target);
	3. se libro già presente --> spunta avviso
	   altrimenti            --> getLibraries(from_target)
	4. se libro non presente --> addBook(event)
**/

/** Costruisce il codice HTML per visualizzare i contenuti **/
function appendHTML(url,book_id,title,author,descr) {
	const article = document.createElement('article');
	const div1 = document.createElement('div');
	const div2 = document.createElement('div');
	const div3 = document.createElement('div');

	article.classList.add('flex-item');
	div1.classList.add('first-child');
	div2.classList.add('second-child');
	div3.classList.add('third-child');
	div3.classList.add('explore');

	const img_elem = document.createElement('img');
	const h3 = document.createElement('h3');
	const h5 = document.createElement('h5');

	img_elem.src = url;
	h3.textContent = title;
	
	if(author === undefined)
		h5.textContent = 'No author found for this book!';
	else 
		h5.textContent = author;

	let p = document.createElement('p');
	
	if(descr === undefined)
		p.textContent = 'No description found for this book!';
	else
		p.textContent = descr;

	const form = document.createElement('form');
	const button = document.createElement('input');
	button.setAttribute("type","submit");
	button.setAttribute("value","+");
	button.setAttribute("id","addToLib");

	article.setAttribute("data-book-id",book_id);
	article.setAttribute("data-book-cover",url);
	article.setAttribute("data-book-title",title);
	article.setAttribute("data-book-author",author);

	form.appendChild(button);

	div1.appendChild(img_elem);
	div2.appendChild(h3);
	div2.appendChild(h5);
	div2.appendChild(p);
	div3.appendChild(form);

	article.appendChild(div1);
	article.appendChild(div2);
	article.appendChild(div3);
	results_container.appendChild(article);
	results_container.classList.add('scroll');
}

/** Main **/
const search_content = document.querySelector('#search-content');
const content = document.querySelector('#content');
const results_container = document.querySelector('#flex-container');
search_content.addEventListener('submit',searchBook);