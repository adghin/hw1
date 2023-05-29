function onResponse(response) {
	return response.json();
}

function jsonResponse(json) {
	results_container.classList.add('winners');

	let pos = 0; 
	for(const item of json) {	
		pos++;
		appendHTML(item.titolo,item.autori,item.cover,item.rating_medio,item.num_voti,pos);
	}
}

function appendHTML(title,author,url,avgRate,numVoti,position) {
	const article = document.createElement('article');
	const div0 = document.createElement('div');
	const div1 = document.createElement('div');
	const div2 = document.createElement('div');
	const div3 = document.createElement('div');
	const div4 = document.createElement('div');
	const div5 = document.createElement('div');

	article.classList.add('flex-item');
	div0.classList.add('zero-child');

	if(position == 1) div0.setAttribute("id","gold");
	if(position == 2) div0.setAttribute("id","silver");
	if(position == 3) div0.setAttribute("id","bronze");

	div1.classList.add('first-child');
	div2.classList.add('second-child');

	div1.classList.add('resized');
	div2.classList.add('resized');

	div3.classList.add('third-child');

	div4.classList.add('fourth-child');
	div5.classList.add('fifth-child');

	const img_elem = document.createElement('img');
	img_elem.classList.add('resized');

	const h3 = document.createElement('h3');
	const h5 = document.createElement('h5');

	h3.classList.add('resized');
	h5.classList.add('resized');

	img_elem.src = url;
	h3.textContent = title;
	h5.textContent = author;

	div1.appendChild(img_elem);
	div2.appendChild(h3);
	div3.appendChild(h5);

	const star_div = document.createElement('div');
	const stars = document.createElement('span');
	stars.classList.add('star');
	stars.setAttribute("data-star-rate",avgRate);

	star_div.appendChild(stars);
	
	star_div.classList.add('star-div');
	div4.appendChild(star_div);

	const span = document.createElement('span');
	span.textContent = numVoti;
	div5.appendChild(span);

	article.appendChild(div0);
	article.appendChild(div1);
	article.appendChild(div2);
	article.appendChild(div3);
	article.appendChild(div4);
	article.appendChild(div5);

	results_container.appendChild(article);
}

const url = "http://localhost/hw1/php/get_winners.php";

fetch(url).then(onResponse).then(jsonResponse);

const results_container = document.querySelector('#flex-container');
