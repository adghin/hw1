function createLibrary(event) {	
	event.preventDefault();
	
	const form = event.currentTarget;

	if(form.querySelector('.error-msg')) {
		form.removeChild(form.querySelector('.error-msg'));
	}
	if((form.querySelector('#content').value == "") || 
		(form.querySelector('#content').value.trim().length === 0)) {
			const error = document.createElement('p');
			error.textContent = "Il campo non può essere vuoto!";
			error.classList.add('error-msg');

			form.appendChild(error);
			form.querySelector('#content').value = "";
	}
	else {
		const library_name = form.querySelector('#content').value;

		const url = "http://localhost/hw1/php/add_library.php";
		let data = new FormData();
		data.append("lib-name",library_name);

		fetch(url,
				{
					method: 'POST',
					body: data 
				}
		).then(onResponse).then(validResponse); 
	}
}

function onResponse(response) {
	return response.json();
}

function validResponse(json) {
	if(json.added_library == true) {
		modal.classList.add('hidden');
		document.body.classList.remove('no-scroll');

		const a = document.createElement('a');
		a.setAttribute("href","");
		a.classList.add('libs');
		a.textContent = json.library_name;
		a.setAttribute("id",json.library_id);

		a.addEventListener('click',addBook);

		if(document.querySelector('#nolib') !== null) {
			document.querySelector(".div-options").removeChild(document.querySelector("#nolib"));
		}
		
		document.querySelector(".div-options").insertBefore(a,document.querySelector('.libs.create'));
	}
}

/** addLibrary apre la modale con il form **/
function addLibrary(event) {
	alert_modal.innerHTML = '';
	const h3 = document.createElement('h3');
	const close = document.createElement('span');
	close.classList.add('closeModal');

	h3.textContent = "INSERISCI IL NOME DELLA LIBRERIA";

	const form = document.createElement('form');
	const input = document.createElement('input');
	const submit = document.createElement('input');

	input.setAttribute("type","text");
	input.setAttribute("name","lib-name");
	input.setAttribute("placeholder","Nome libreria...");
	input.setAttribute("id","content");

	submit.setAttribute("type","submit");
	submit.setAttribute("value","CREA");

	form.appendChild(input);
	form.appendChild(submit);

	form.addEventListener('submit',createLibrary);

	alert_modal.appendChild(close);
	alert_modal.appendChild(h3);
	alert_modal.appendChild(form);

	close.addEventListener('click',() => {
		alert_modal.innerHTML = '';
		modal.classList.add('hidden');
		document.body.classList.remove('no-scroll');
	});

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

const modal = document.querySelector('.modal');
const alert_modal = modal.querySelector('.alert');
window.addEventListener('keydown',closeModal);