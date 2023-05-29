function validateUser(event) {
	let error;
	/* il controllo per gli spazi bianchi non funziona */
	if( (register_form.email.value.trim().length === 0) || (register_form.email.value == "") ||
		(register_form.username.value.trim().length === 0) || (register_form.username.value == "") || 
		(register_form.password.value.trim().length === 0) || (register_form.password.value == "") || 
		(register_form.repassword.value.trim().length === 0) || (register_form.repassword.value == "") ) {

			error = "Per favore compila tutti i campi!";
			createError(error,event.target.parentNode);
			event.preventDefault();
	}
	else {
		removeError(event.target.parentNode);

		let data = new FormData();
		data.append("username",register_form.username.value);
		data.append("email",register_form.email.value);
	
		fetch("http://localhost/hw1/php/checkuser_reg.php",
			{
				  method:'POST',
	     		  body: data
			}).then(onResponse).then(onUserInfo);
		
		event.preventDefault();
	}
}

function onResponse(response) {
	return response.json();
}

function onUserInfo(json) {
	if(json !== null) {
		let error;
		if(json.email == register_form.email.value) {
			error = "Email già in uso!";
			register_form.email.classList.add('blurred');
			createError(error,register_form.email.parentNode);
		}
		else {
			register_form.email.classList.remove('blurred');
			removeError(register_form.email.parentNode);
		}
		if(json.username == register_form.username.value) {
			error = "Username già in uso!";
			register_form.username.classList.add('blurred');
			createError(error,register_form.username.parentNode);
		}
		else {
			register_form.username .classList.remove('blurred');
			removeError(register_form.username.parentNode);
		}
	}
	else {
		register_form.submit();
	}
}

function onBlurEmail(event) {
	const validEmail = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
	const parent = event.target.parentNode;
	if(!event.target.value.match(validEmail)) {
		const error = "Ricontrolla la tua email, sembra non essere valida!";
		createError(error,parent);
	}
	else {
		removeError(parent);
	}
}

function onBlurPwd(event) {
	const validPwd   = /^(?=.{8,}$)(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?\W)/;
	const parent = event.target.parentNode;
	if(!event.target.value.match(validPwd)) {
		const error = "La password deve avere una lungehzza di almeno 8 caratteri e contenere almeno uno tra i seguenti: 1 carattere minuscolo, 1 carattere maiuscolo, un numero e un carattere speciale";
		createError(error,parent);
	}
	else {
		removeError(parent);
	}
}

function onBlurRepwd(event) {
	const parent = event.target.parentNode;
	if(!(event.target.value == register_form.password.value)) {
		const error = "Re-inserisci la stessa password del campo *Password*";
		createError(error,parent);
	}
	else {
		removeError(parent);
	}
}

function createError(error_msg,parent) {
	const error = parent.querySelector('.input-error');
	error.classList.remove('hidden');
	error.textContent = error_msg;
}

function removeError(parent) {
	parent.querySelector('.input-error').classList.add('hidden');
	parent.querySelector('.input-error').textContent = '';
}

/*** Main ***/
let error;
const register_form = document.forms['register'];
register_form.addEventListener('submit',validateUser);
register_form.email.addEventListener('blur',onBlurEmail);
register_form.password.addEventListener('blur',onBlurPwd);
register_form.repassword.addEventListener('blur',onBlurRepwd);
