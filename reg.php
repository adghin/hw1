<?php
	require_once('php/user_auth.php');
	if(isAuth()) {
		header("Location: home.php");
		exit;
	}

	/* Verifichiamo di aver ricevuto i dati POST */
	if(isset($_POST["email"]) && isset($_POST["username"]) && isset($_POST["password"]) && isset($_POST["repassword"])) {

		require_once('php/db_conn.php');

		/* Controllo validità dei dati */
		$validEmail = "/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/";
		$validPwd   = "/^(?=.{8,}$)(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?\W)/";
		$error = array();

		if(empty($_POST["email"]) || empty($_POST["username"]) || empty($_POST["password"]) || empty($_POST["repassword"])) {
			$flag_error = true;
			$error[] = "Per favore inserisci tutti i campi!";
		}
		else {
			if(!preg_match($validEmail,$_POST["email"])) {
				$flag_error = true;
				$error[]  = "Per favore inserisci una email valida!";
			}	
			if(!preg_match($validPwd,$_POST["password"])) {
				$flag_error = true;
				$error[] = "La password deve avere una lungehzza di almeno 8 caratteri e contenere almeno uno tra i seguenti: 1 carattere minuscolo, 1 carattere maiuscolo, un numero e un simbolo tra ( -_$&)!";
			}
			if(strcmp($_POST["password"], $_POST["repassword"]) !== 0) {
				$flag_error = true;
				$error[] = "Per favore inserisci la stessa password del campo *Password*!";
			}
		}

		if(!isset($flag_error)) {
			/* Escape dell'input */
			$email = mysqli_real_escape_string($connection,$_POST["email"]);
			$username = mysqli_real_escape_string($connection,$_POST["username"]);
			$pwd = mysqli_real_escape_string($connection,$_POST["password"]);

			/* Hasing della pwd */
			$pwd_hash = password_hash($pwd, PASSWORD_BCRYPT);

			/* Creo query di inserimento nuovo utente */
			$query = "INSERT INTO utenti(email,username,password) VALUES('".$email."' , '".$username."' , '".$pwd_hash."')";

			$result = mysqli_query($connection,$query);
			if(!$result) die("Errore inserimento nuovo utente!");
			else {
				$_SESSION["_bookclub_username"] = $_POST["username"];
				$_SESSION["_bookclub_user_id"]  = mysqli_insert_id($connection);
				mysqli_close($connection);
				header("Location: login.php");
				exit;
			}
		}

	}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>BookClub - Crea un account</title>
		<link rel="stylesheet" href="css/hw1.css">
		<link rel="stylesheet" href="css/loginreg.css">
		<link rel="stylesheet" href="css/responsive.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Charm&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Charm&family=Libre+Baskerville&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<script src="js/reg.js" defer></script>
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
				<h1>Crea un nuovo account</h1>
				<?php
					if(isset($flag_error)) {
						echo "<br>";
						echo "<span class='error-reg'>";
						foreach ($error as $value) {
							echo $value;
							echo "<br>";
						}
						echo "</span>";
						echo "<br>";
					}
				?>
				<form name="register" method="post">
				<span class="input-error hidden"></span>
				<label for="email"> Email 
					<input type="text" name="email" value="<?php if(isset($_POST["email"])) { echo $_POST["email"]; } ?>" placeholder="Inserisci la tua email...">
					<span class="input-error hidden"></span>
				</label>
				<label for="username"> Username
					<input type="text" name="username" value="<?php if(isset($_POST["username"])) { echo $_POST["username"]; } ?>" placeholder="Inserisci il tuo username...">
					<span class="input-error hidden"></span>
				</label>
				<label> Password 
					<input type="password" name="password" placeholder="Inserisci la tua pasword...">
					<span class="input-error hidden"></span>
				</label>
				<label> Conferma password 
					<input type="password" name="repassword" placeholder="Inserisci di nuovo la tua pasword...">
					<span class="input-error hidden"></span>
				</label>
				<label> &nbsp; <input type="submit" value="Registrati"></label>
				</form>
				<p>Hai già un account?</p>
				<a href="login.php">Accedi al tuo account</a>
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