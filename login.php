<?php
	require_once('php/user_auth.php');
	if(isAuth()) {
		header("Location: account.php");
		exit;
	}

	if(isset($_POST["username"]) && isset($_POST["password"])) {

		require_once('php/db_conn.php');

		$username = mysqli_real_escape_string($connection,$_POST["username"]);
		$pwd = mysqli_real_escape_string($connection,$_POST["password"]);

		$query = "SELECT * FROM utenti WHERE username = '".$username."'";
		$result = mysqli_query($connection,$query);

		if($result) {

			$num_rows = mysqli_num_rows($result);

			if($num_rows == 0) 
				$not_present = true;
			else {
				$row = mysqli_fetch_assoc($result);
				mysqli_close($connection);

				if(!password_verify($_POST["password"], $row["password"])) 
					$wrong_credentials = true;
				else {
					/* Creo sessione per l'utente */
					$_SESSION["_bookclub_username"] = $row["username"];
					$_SESSION["_bookclub_user_id"]  = $row["id_utenti"];
					header('Location: account.php');
					exit;
				}
			}
		}
	}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>BookClub - Login</title>
		<link rel="stylesheet" href="css/hw1.css">
		<link rel="stylesheet" href="css/loginreg.css">
		<link rel="stylesheet" href="css/responsive.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Charm&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Charm&family=Libre+Baskerville&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<script src="js/login.js" defer></script>
	</head>

	<body>
		<nav class="navlog">
			<div class="logo"></div>
			<div>
				<a class="button" href="home.php">Torna alla homepage</a>
			</div>
		</nav>
		<section class="logreg-section">
			<div class="logreg-container">
				<h1>Accedi al tuo account</h1>
				<?php
					if(isset($not_present)) {
						echo "<br>";
						echo "<span class='error'>Non abbiamo trovato un utente con i dati da te inseriti!</span>";
						echo "<br>";
					}

					if(isset($wrong_credentials)) {
						echo "<br>";
						echo "<span class='error'>Sembra che le credenziali non siano corrette!</span>";
						echo "<br>";
					}
				?>
				<span class="error hidden"></span>
				<form name="login" method="post">
				<label> Username <input type="text" name="username" placeholder="Inserisci il tuo username..."></label>
				<label> Password <input type="password" name="password" placeholder="Inserisci la tua pasword..."></label>
				<label> &nbsp; <input type="submit" value="Accedi"></label>
				</form>
				<p>Non hai un account?</p>
				<a href="reg.php">Registrati</a>
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