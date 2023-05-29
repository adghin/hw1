<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}

	if(isset($_POST["id"]) && isset($_POST["title"]) && isset($_POST["author"]) && isset($_POST["cover"]) && isset($_POST["lib_id"])) {
		require_once('db_conn.php');
		/* Preparazione dei dati per la query */
		$book_id = mysqli_real_escape_string($connection,$_POST["id"]);
		$lib_id  = mysqli_real_escape_string($connection,$_POST["lib_id"]);

		/* Controllo che l'ID del libro non sia già presente nel DB, altrimenti lo inserisco nella tabella libro per popolare il DB */
		$query = "SELECT * FROM libro WHERE id_libro = '".$book_id."'";
		$result = mysqli_query($connection,$query);

		if($result) {
			$num_rows = mysqli_num_rows($result);
			if($num_rows == 0) {	/* Vuol dire che questo ID non è presente nel DB del sito quindi lo inserisco */
				$book_title = mysqli_real_escape_string($connection,$_POST["title"]);
				$book_author = mysqli_real_escape_string($connection,$_POST["author"]);
				$book_cover  = mysqli_real_escape_string($connection,$_POST["cover"]);

				$query = "INSERT INTO libro(id_libro,titolo,autori,cover) VALUES('".$book_id."' , '".$book_title."' , '".$book_author."' , '".$book_cover."')";

				$result = mysqli_query($connection,$query);
			}
		}
		
		/* Controllo che l'ID del libro non sia presente in una delle librerie dell'utente */
		$query = 	"SELECT * 
					FROM libri_libreria L1
					JOIN libreria L2
					ON L1.id_libreria = L2.lib_id
					WHERE L1.id_libro = '".$lib_id."'
					AND L2.usr_id = '".$_SESSION["_bookclub_user_id"]."'";

		$result = mysqli_query($connection,$query);

		if($result) {
			$num_rows = mysqli_num_rows($result);

			if($num_rows == 0) { 
			#vuol dire che il libro non è presente in una delle librerie dell'utente, quindi lo inserisco nella libreria specificata
				$query = "INSERT INTO libri_libreria(id_libro,id_libreria) VALUES('".$book_id."' , '".$lib_id."')";
				$result = mysqli_query($connection,$query) or die("Errore durante INSERT");

				if($result == true) echo json_encode(array("added_to_lib" => true));
				else 				echo json_encode(array("added_to_lib" => false));
			}
		}

		mysqli_close($connection);
	}
?>