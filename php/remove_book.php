<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}

	if(isset($_POST["book_id"]) && isset($_POST["lib_id"])) {
		require_once('db_conn.php');

		$book_id = mysqli_real_escape_string($connection,$_POST["book_id"]);
		$lib_id = mysqli_real_escape_string($connection,$_POST["lib_id"]);
		/** N.B : eliminiamo il libro solo dalla libreria dell'utente e non direttamente dal DB, in tal modo se un altro utente cerca il libro e vuole aggiungerlo ad una sua libreria, non faremo un altro inserimento nel DB per la tabella libro, ottimizzando così le prestazioni **/
		$query = "DELETE FROM libri_libreria WHERE id_libro = '".$book_id."' AND id_libreria = '".$lib_id."'";
		$result = mysqli_query($connection,$query);
		if($result) {
			echo json_encode(array("deleted" => true));
		}
	}
?>