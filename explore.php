<?php
	require_once('php/user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>BookClub - Esplora la libreria</title>
		<link rel="stylesheet" href="css/hw1.css">
		<link rel="stylesheet" href="css/acc.css">
		<link rel="stylesheet" href="css/responsive.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Charm&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Charm&family=Libre+Baskerville&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<script src="js/add_lib.js" defer></script>
		<script src="js/search.js" defer></script>
		<script src="js/resp_menu.js" defer></script>
	</head>

	<body>
		<nav class="navlog">
			<div class="logo"></div>
			<div id="mobile-menu"></div>
			<div id="links">
				<a href="home.php">Home</a>
				<a href="explore.php">Explore</a>
				<a href="librerie.php">Gestisci librerie</a>
				<a href="account.php" class="button">Il tuo profilo <img src="css/acc-icon.png"></a>
				<a href="logout.php" class="button">Logout</a>
			</div>
		</nav>
		<section class="account-section">
			<div class="col-2 explore">
				<span>CERCA UN LIBRO</span>
				<form id="search-content">
					<input id="content" type="text" placeholder="Titolo/Autore/ISBN...">
				</form>
				<h6>Powered by<img class="powered" src="css/google.png"></h6>
				<div id="flex-container" class="hidden">
				</div>
			</div>
			<div class="modal hidden">
				<div class="alert"></div>
			</div>
		</section>
	</body>
</html>