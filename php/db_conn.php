<?php
	/* Apro connessione al DB */
	$connection = mysqli_connect("localhost","root");
	if(!$connection) die(mysqli_connect_error());

	/* Collego la connessione al database desiderato */
	$db = "hw1";
	$select_db = mysqli_select_db($connection,$db);
	if(!$select_db) die("Errore nel collegamento al DB hw1");
?>