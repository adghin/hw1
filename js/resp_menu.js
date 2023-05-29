function showMenu(event) {
	const links = document.querySelector('#links').classList.toggle('responsive');
}

function openLibs(event) {
	const libs = document.querySelector('#libs-col').classList.toggle('opened');
	show_libs.classList.toggle('change-arrow');
}

const menu = document.querySelector('#mobile-menu');
menu.addEventListener('click',showMenu);

const show_libs = document.querySelector('#show-libs');
if(show_libs) show_libs.addEventListener('click',openLibs);