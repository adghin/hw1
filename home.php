<?php
	require_once('php/user_auth.php');
	if(isAuth()) {
		$user_auth = true;
	}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>BookClub - Home</title>
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="stylesheet" href="css/hw1.css">
		<link rel="stylesheet" href="css/home.css">
		<link rel="stylesheet" href="css/responsive.css">
		<link rel="stylesheet" href="css/stars_decimals.css">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Charm&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Charm&family=Libre+Baskerville&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<script src="js/winners.js" defer></script>
		<script src="js/resp_menu.js" defer></script>
	</head>
	<body>
		<header>
			<nav id="home-nav">
				<div class="logo"></div>
				<div id="mobile-menu"></div>
				<div id="links">
					<a href="home.php">Home</a>
					<a href="explore.php">Explore</a>
					<?php
						if(isset($user_auth)) {
							echo "<a href='account.php' class='button'>Il tuo profilo <img src='css/acc-icon.png'></a>";
							echo " ";
							echo "<a href='logout.php' class='button'>Esci</a>";
						}
						else {
							echo "<a href='login.php' class='button'> <img src='css/login.png'> Entra</a>";
							echo " ";
							echo "<a href='reg.php' class='button'> <img src='css/signup.png'> Unisciti!</a>";
						}
					?>
				</div>
			</nav>
			<div id="overlay"></div>
			<div id="header-container">
				<h1>Salva e vota i tuoi libri preferiti</h1>
				<h4>Tieni traccia dei tuoi libri e contribuisci a portare quelli che più apprezzi in cima alla classifica. Entra a far parte della community di <em>BookClub</em></h4>
			</div>
		</header>
		<section class="rated-books">
			<span>LIBRI PIÙ APPREZZATI DAGLI UTENTI</span>
			<div id="flex-container" class="winners">
				<div class="flex-item">
					<span class="zero-child"></span>
					<span class="first-child resized">Copertina</span>
					<span class="second-child resized">Titolo</span>
					<span class="third-child resized">Autore</span>
					<span class="fourth-child resized">Voto medio</span>
					<span class="fifth-child resized">Num. voti </span>
				</div>
			</div>
		</section>
		<footer>
			<div>
				<span><em>“I libri sono gli amici più tranquilli e costanti, e gli insegnanti più pazienti”, Charles W. Eliot</em></span>
			</div>
			<div class="footer-info">
				<span>Adrian</span>
				<span>Ghinea</span>
				<span>1000014775</span>
			</div>
		</footer>
	</body>
</html>