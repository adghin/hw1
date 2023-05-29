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
		<link rel="stylesheet" href="css/responsive.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Charm&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Charm&family=Libre+Baskerville&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<script src="js/get_books.js" defer></script>
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
			<div class="col-1">
				<div class="col-item">
					<div id="circle"></div>
					<?php
						echo "<h3>";
						echo "Bentornato, ".$_SESSION["_bookclub_username"]."";
						echo "</h3>";
					?>
				</div>
				<div id="show-libs"></div>
				<div class="col-item" id="libs-col">
					<span class="libs-label">LE TUE LIBRERIE</span>
					<?php 
						require_once('php/db_conn.php');
						$query = "SELECT nome,lib_id FROM libreria WHERE usr_id = '".$_SESSION["_bookclub_user_id"]."'";
						$result = mysqli_query($connection,$query);
						if($result) {
							$num_rows = mysqli_num_rows($result);
							if($num_rows == 0) {
								echo "<span class='libs' id='nolib'>Nessuna libreria presente!</span>";
								echo "<a href='librerie.php' class='mylibs'>Gestisci librerie</a>";
							}
							else {
								while($row = mysqli_fetch_row($result)) {
									$lib_names[] = $row;
								}
								mysqli_close($connection);
								echo "<a href='' class='libs' id='all'>Tutti i libri</a>";
								for($i = 0; $i < count($lib_names); $i++) {
									echo "<a href='' class='libs' id='".$lib_names[$i][1]."'>".$lib_names[$i][0]."</a>";
								}
								echo "<a href='librerie.php' class='mylibs'>Gestisci librerie</a>";
							}
						} 
					?>
				</div>
				</div>
			</div>
			<div class="col-2">
				<div class="col-item">
					<span>I TUOI LIBRI</span>
				</div>
				<div id="flex-container" class="hidden">
					<div class="flex-item">
						<span class="first-child resized">Copertina</span>
						<span class="second-child resized">Titolo</span>
						<span class="third-child resized">Autore</span>
						<span class="fourth-child resized">Voto</span>
						<span class="fifth-child resized">Libreria</span>
					</div>
				</div>
				<div class="modal hidden">
					<div class="alert"></div>
				</div>
			</div>
		</section>
	</body>
</html>