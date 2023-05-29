<?php
	require_once('db_conn.php');

	/* Escape dell'input */
	$email = mysqli_real_escape_string($connection,$_POST["email"]);
	$username = mysqli_real_escape_string($connection,$_POST["username"]);

	/* Verifico che username o email non siano già presenti nel DB, altrimenti ritorno un errore e non faccio andare avanti */
	$query = "SELECT email,username FROM utenti WHERE email = '".$email."' OR username = '".$username."'";
	$result = mysqli_query($connection,$query);

	if($result) {
		$num_rows = mysqli_num_rows($result);

		if($num_rows > 0) {
			$row = mysqli_fetch_row($result);
			mysqli_close($connection);

			$data = array("email" => $row[0], "username" => $row[1]);
			echo json_encode($data);
		}	
		else {
			echo json_encode(null);
		}
	}
?>