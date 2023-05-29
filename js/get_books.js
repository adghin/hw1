function onResponse(response) {
	return response.json();
}

function onJSON(json) {
	/** Svuotiamo tutti gli article eventualmente già presenti; il .querySelectorAll(':not(:first-child)') serve a non prendere anche
	il primo div di results_container ossia i label **/
	while(results_container.querySelector('article')) {
		results_container.querySelector('article').remove();
	}

	if(json !== null) {
		/* Se il messaggio di "No libri presenti" è spuntato, lo rimuoviamo */
		if(results_container.querySelector('p')) {
			results_container.removeChild(results_container.querySelector('p'));
		}

		results_container.querySelector(':first-child').classList.remove('hidden');

		for(item of json) {
			appendHTML(item.cover,item.id_libro,item.titolo,item.autori,item.rate,item.nome,item.id_libreria);
		}
	}
	else {
		results_container.querySelector(':first-child').classList.add('hidden');
			
		if(results_container.querySelector('p')) {
			results_container.removeChild(results_container.querySelector('p'));
		}

		const p = document.createElement('p');
		p.textContent = "Nessun libro presente... vai su ";

		const a = document.createElement('a');
		a.textContent = "Explore";
		a.href = 'explore.php';
		a.classList.add('new');

		p.appendChild(a);
		const content = document.createTextNode(" e cerca i libri che desideri");
		p.appendChild(content);
		results_container.appendChild(p);
	}
}

function onBookRemoved(json) {
	if(json.deleted == true) {
		alert_modal.innerHTML = '';
		modal.classList.add('hidden');
		document.body.classList.remove('no-scroll');

		getBooks();
	}
}

function onStar(json) {
	const article_id = document.querySelector(`article[data-book-id="${json.id}"]`)
	const msg = document.createElement('p');

	if(json == null) {
		msg.textContent = "C'è stato un errore...";
	}
	else {
		if(json.updated == true) {
			msg.textContent = "Voto aggiornato con successo!";
		}
		if(json.rated == true) {
			msg.textContent = "Voto aggiunto con successo!";
		}
	}

	article_id.querySelector('.fourth-child').appendChild(msg);

	setTimeout(
			function() {
				article_id.querySelector('.fourth-child').removeChild(msg)
			},3000);
}

function getBooks() {
	const url = "http://localhost/hw1/php/get_user_books.php";
	fetch(url).then(onResponse).then(onJSON);
}

/**
	Invece di associare il nome dell'handler per l'eventListner => 'click' sui button, eseguiamo le azioni tramite 
	funzioni anonime nidificate, in modo da avere accesso al lexical scope e quindi poter prendere i dati dal
	parentNode.dataset dell'event.currentTarget (cioè il libro) in questione 
**/
function removeBook(event) {
	openModal();

	const book = event.currentTarget;

	document.querySelector('#yes-btn').addEventListener('click',
		() => {
				const data = new FormData();
				data.append("book_id",book.parentNode.dataset.bookId);
				data.append("lib_id",book.parentNode.dataset.bookLibId);

				const url = "http://localhost/hw1/php/remove_book.php";
				fetch(url,
					{
						method: 'POST',
						body: data
					}).then(onResponse).then(onBookRemoved);
	});
	
	document.querySelector('#no-btn').addEventListener('click',(event) => {
		alert_modal.innerHTML = '';
		modal.classList.add('hidden');
		document.body.classList.remove('no-scroll');
	});
}

function assignStars(book_id,rating) {
	for(let i = 0; i < rating; i++) {
		let i_str = String(i+1);
		let id_str = String(book_id);
		const rates = document.querySelector(`[data-book-id="${id_str}"][data-star-rate="${i_str}"]`);
		rates.classList.add('rated');
	}
}

function selectStar(event) {
	const url = "http://localhost/hw1/php/rate_book.php";

	let data = new FormData();
	data.append("book-id",event.currentTarget.dataset.bookId);
	data.append("star-val",event.currentTarget.dataset.starRate);

	const parent = event.currentTarget.parentNode;
	const children = parent.querySelectorAll('.star');

	for(item of children) item.classList.remove('rated');

	assignStars(event.currentTarget.dataset.bookId,event.currentTarget.dataset.starRate);

	fetch(url,
			{
				method: 'POST',
				body: data
			}
	).then(onResponse).then(onStar);
}

function appendHTML(url,book_id,title,author,rating,lib_name,lib_id) {
	const article = document.createElement('article');
	const div1 = document.createElement('div');
	const div2 = document.createElement('div');
	const div3 = document.createElement('div');
	const div4 = document.createElement('div');
	const div5 = document.createElement('div');
	const div6 = document.createElement('div');

	article.classList.add('flex-item');
	div1.classList.add('first-child');
	div2.classList.add('second-child');

	div1.classList.add('resized');
	div2.classList.add('resized');

	div3.classList.add('third-child');
	div4.classList.add('fourth-child');
	div5.classList.add('fifth-child');
	div6.classList.add('sixth-child');

	div6.setAttribute("title","Rimuovi libro");

	const img_elem = document.createElement('img');
	img_elem.classList.add('resized');

	const h3 = document.createElement('h3');
	const h5 = document.createElement('h5');

	h3.classList.add('resized');
	h5.classList.add('resized');

	img_elem.src = url;
	h3.textContent = title;
	
	if(author === undefined)
		h5.textContent = 'No author found for this book!';
	else 
		h5.textContent = author;

	div1.appendChild(img_elem);
	div2.appendChild(h3);
	div3.appendChild(h5);

	const n_stars = 5;
	const star_div = document.createElement('div');
	for(let i = n_stars; i > 0; i--) {	
		const star = document.createElement('span');

		star.setAttribute("data-book-id",book_id);
		star.setAttribute("data-star-rate",i);
		star.setAttribute("id",book_id);

		star.classList.add('star');
		star_div.appendChild(star);
	}

	star_div.classList.add('star-div');
	div4.appendChild(star_div);

	const p = document.createElement('p');
	p.textContent = lib_name;
	div5.appendChild(p);

	article.setAttribute("data-book-id",book_id);
	article.setAttribute("data-book-lib-id",lib_id);

	article.appendChild(div1);
	article.appendChild(div2);
	article.appendChild(div3);
	article.appendChild(div4);
	article.appendChild(div5);
	article.appendChild(div6);
	results_container.appendChild(article);

	if(rating !== null) {
		assignStars(book_id,rating);
	}

	const star_list = div4.querySelectorAll('.star');
	for(item of star_list) item.addEventListener('click',selectStar);

	div6.addEventListener('click',removeBook);
}

function openModal(event) {
	alert_modal.innerHTML = '';
	const h3 = document.createElement('h3');
	h3.textContent = "SEI SICURO DI VOLER RIMUOVERE IL LIBRO?";

	const options = document.createElement('div');
	const yes = document.createElement('button');
	const no = document.createElement('button');

	yes.type = "button";
	no.type  = "button";

	yes.setAttribute("id","yes-btn");
	no.setAttribute("id","no-btn");

	yes.textContent = "Sì";
	no.textContent  = "No";

	alert_modal.appendChild(h3);

	options.appendChild(yes);
	options.appendChild(no);

	alert_modal.appendChild(options);

	modal.classList.remove('hidden');
	document.body.classList.add('no-scroll');
}

function closeModal(event) {
	if(event.key === 'Escape') {
		alert_modal.innerHTML = '';
		modal.classList.add('hidden');
		document.body.classList.remove('no-scroll');
	}
}

/** Main **/
getBooks(); 

function selectedLibrary(event) {
	event.preventDefault();

	if(event.currentTarget.id == 'all') getBooks();
	else {
		let data = new FormData();
		data.append("lib_id",event.currentTarget.id);

		const url = "http://localhost/hw1/php/get_user_books.php";
		fetch(url,
		{
			method: 'POST',
			body: data
		}).then(onResponse).then(onJSON);
	}
}

const libraries = document.querySelectorAll('.libs');
for(item of libraries) {
	item.addEventListener('click',selectedLibrary);
}

const results_container = document.querySelector('#flex-container');
const modal = document.querySelector('.modal');
const alert_modal = modal.querySelector('.alert');
window.addEventListener('keydown',closeModal);