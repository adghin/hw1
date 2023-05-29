function onResponse(response) {
	return response.json();
}

function onJSONLibs(json) {
	results_container.innerHTML = '';
	if(json !== null) {
		for(item of json) {
			appendHTML(item.id,item.name);
		}
	}
}

function onEdited(json) {
	if(json.correctly_edited == true) {
		getLibraries();
	}
}

function renameLibrary(event) {
	const library = event.currentTarget.parentNode.parentNode;
	const name = library.querySelector('.first-child');

	const rename_option = document.querySelectorAll('.second-child span');
	const remove_option = document.querySelectorAll('.third-child span');

	for(item of rename_option) {
		item.classList.add('hide');
		item.removeEventListener('click',renameLibrary);
	}

	for(item of remove_option) {
		item.classList.add('hide');
		item.removeEventListener('click',removeLibrary);
	}

	const names = document.querySelectorAll('.first-child');

	for(item of names) {
		if(item !== name) {
			item.querySelector('p').classList.add('hide');
		}
	}

	const content = name.textContent;

	name.innerHTML = '';

	const form = document.createElement('form');
	form.classList.add('edit-form');

	const input = document.createElement('input');
	const submit = document.createElement('input');
	const abort = document.createElement('button');

	input.name = "lib_name";
	input.id = library.dataset.libId;
	input.setAttribute("value",content);
	input.setAttribute("type","text");

	input.classList.add('edit-input')

	submit.setAttribute("type","submit");
	submit.value = "Salva";

	submit.classList.add('edit-submit');

	abort.setAttribute("type","button");
	abort.textContent = "Annulla";
	abort.classList.add('abort');

	abort.classList.add('edit-abort');

	form.appendChild(input);
	form.appendChild(submit);
	form.appendChild(abort);

	name.appendChild(form);

	abort.addEventListener('click',() => {
		const p = document.createElement('p');
		p.textContent = content;

		name.innerHTML = '';
		name.appendChild(p);

		for(item of rename_option) {
			item.addEventListener('click',renameLibrary);
			item.classList.remove('hide');
		}

		for(item of remove_option) {
			item.addEventListener('click',removeLibrary);
			item.classList.remove('hide');
		}

		for(item of names) {
			if(item !== name) {
				item.querySelector('p').classList.remove('hide');
			}
		}
	
	});

	form.addEventListener('submit',saveEdit);
}

function saveEdit(event) {
	event.preventDefault();

	const form = event.currentTarget;

	if(form.querySelector('.error-msg')) {
		form.removeChild(form.querySelector('.error-msg'));
	}
	if((form.querySelector('.edit-input').value == "") || 
		(form.querySelector('.edit-input').value.trim().length === 0)) {
			const error = document.createElement('p');
			error.textContent = "Il campo non può essere vuoto!";
			error.classList.add('error-msg');

			form.appendChild(error);
			form.querySelector('.edit-input').value = "";
	}
	else {
		const id = form.querySelector('.edit-input').id;
		const value = form.querySelector('.edit-input').value;

		let data = new FormData();
		data.append("lib_id",id);
		data.append("lib_name",value);

		const url = "http://localhost/hw1/php/edit_libraries.php";
		fetch(url,
			{
				method: 'POST',
				body: data
		}).then(onResponse).then(onEdited);
	}
}

function openModal(msg) {
	alert_modal.innerHTML = '';
	const h3 = document.createElement('h3');
	h3.textContent = "Rimuovere la libreria comporterà la rimozione di tutti i libri ad essa associati!";

	const options = document.createElement('div');
	const yes = document.createElement('button');
	const no = document.createElement('button');

	yes.type = "button";
	no.type  = "button";

	yes.setAttribute("id","yes-btn");
	no.setAttribute("id","no-btn");

	yes.textContent = "Procedi";
	no.textContent  = "Annulla";

	alert_modal.appendChild(h3);

	options.appendChild(yes);
	options.appendChild(no);

	alert_modal.appendChild(options);

	modal.classList.remove('hidden');
	document.body.classList.add('no-scroll');
}

function removeLibrary(event) {
	const msg = "Rimuovere la libreria comporterà la rimozione di tutti i libri ad essa associati!";
	openModal(msg);
	
	const parent = event.currentTarget.parentNode.parentNode;
	
	document.querySelector('#yes-btn').addEventListener('click',
		() => {
				const data = new FormData();
				data.append("lib_id",parent.dataset.libId);
				data.append("option","delete");

				const url = "http://localhost/hw1/php/edit_libraries.php";
				fetch(url,
					{
						method: 'POST',
						body: data
					}).then(onResponse).then(onLibRemoved);
	});
	
	document.querySelector('#no-btn').addEventListener('click',(event) => {
		alert_modal.innerHTML = '';
		modal.classList.add('hidden');
		document.body.classList.remove('no-scroll');
	});
}

/** Costruisce il codice HTML per visualizzare i contenuti **/
function appendHTML(id,name) {
	const article = document.createElement('article');
	const div1 = document.createElement('div');
	const div2 = document.createElement('div');
	const div3 = document.createElement('div');

	article.classList.add('flex-item');
	div1.classList.add('first-child');
	div2.classList.add('second-child');
	div2.classList.add('align-right')
	div3.classList.add('third-child');

	const p = document.createElement('p');
	p.textContent = name;

	const rename = document.createElement('span');
	const remove = document.createElement('span');

	rename.textContent = "Rinomina";
	remove.textContent = "Rimuovi";

	rename.classList.add('edit');

	remove.classList.add('edit');
	remove.classList.add('remove');

	div1.appendChild(p);
	div2.appendChild(rename);
	div3.appendChild(remove);

	article.appendChild(div1);
	article.appendChild(div2);
	article.appendChild(div3);

	article.dataset.libId = id;

	rename.addEventListener('click',renameLibrary);
	remove.addEventListener('click',removeLibrary);

	results_container.appendChild(article);
}

function getLibraries() {
	const url = "http://localhost/hw1/php/get_libraries.php";
	fetch(url).then(onResponse).then(onJSONLibs);
}

getLibraries();

const results_container = document.querySelector('#flex-container');
const create_lib = document.querySelector('.libs.create');

window.addEventListener('keydown',closeModal);
create_lib.addEventListener('click',addLibrary);