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
		<title>BookClub - Il tuo profilo</title>
		<link rel="stylesheet" href="css/hw1.css">
		<link rel="stylesheet" href="css/acc.css">
		<link rel="stylesheet" href="css/edit_libs.css">
		<link rel="stylesheet" href="css/responsive.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Charm&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Charm&family=Libre+Baskerville&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">	
		<script src="js/add_lib.js" defer></script>
		<script src="js/edit_libraries.js" defer></script>
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
			<div class="col-2 edit">
				<div class="col-item">
					<span>LE TUE LIBRERIE</span>
				</div>
				<div id="flex-container" class="edit">
				</div>
				<span class="libs create" data-from-target="edit_libs">Aggiungi una libreria</span>
				<div class="modal hidden">
					<div class="alert"></div>
				</div>
		</section>
	</body>
</html>