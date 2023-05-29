<?php
	/* Controllo che l'utente sia già loggato, così da non doverlo richiedere */
	require_once('db_conn.php');
	session_start();

	function isAuth() {
		if(isset($_SESSION["_bookclub_user_id"])) {
			return $_SESSION["_bookclub_user_id"];
		}
		else {
			return 0;
		}
	}
?>