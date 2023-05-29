function validateUser(event) {
	let error;
 	if((login_form.username.value == "") ||
		(login_form.password.value == "")  || (login_form.username.value.trim().length === 0) || (login_form.password.value.trim().length === 0)) {
			error = "Inserisci le tue credenziali";
			createError(error,event.target.parentNode);
			event.preventDefault();
	}
}

function createError(error_msg,parent) {
	const error = parent.querySelector('.error');
	error.classList.remove('hidden');
	error.textContent = error_msg;

	login_form.username.value = "";
	login_form.password.value = "";
}

/** Main **/
const login_form = document.forms['login'];
login_form.addEventListener('submit',validateUser);