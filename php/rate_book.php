<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}

	if(isset($_POST["star-val"]) && isset($_POST["book-id"])) {
		require_once('db_conn.php');

		/* Controllo che il libro selezionato, appartenente all'utente, non abbia già un rating; altrimenti, aggiorno solamente il valore della colonna rating */
		$book_id = mysqli_real_escape_string($connection,$_POST["book-id"]);
		$star_val = mysqli_real_escape_string($connection,$_POST["star-val"]);

		$query = "SELECT * FROM rating_libri WHERE id_user = '".$_SESSION["_bookclub_user_id"]."' AND id_libro = '".$book_id."'";
		$result = mysqli_query($connection,$query);
	
		if($result) {
			$num_rows = mysqli_num_rows($result);
			if($num_rows == 0) {	/* Se $num_rows = 0 vuol dire che non è presente il rating quindi facciamo l'INSERT */
				$query = "INSERT INTO rating_libri(id_libro,id_user,rate) 
			              VALUES ('".$book_id."' , '".$_SESSION["_bookclub_user_id"]."' , '".$star_val."')";
			    $result = mysqli_query($connection,$query);
			    if(!$result) {
			    	echo json_encode(null);
			    }
			    else {
			    	echo json_encode(array("id" => $_POST["book-id"], "rated" => true));
				}
	 		}
	 		else {	/* Se $num_rows != 0 vuol dire che è già presente il rating quindi facciamo l'UPDATE */
	 			$query = "UPDATE rating_libri
	 		 			  SET rate = '".$star_val."'
	 		 			  WHERE id_libro = '".$book_id."' AND id_user = '".$_SESSION["_bookclub_user_id"]."'";
	 		 	$result = mysqli_query($connection,$query);
	 		 	if(!$result) {
			    	echo json_encode(null);
			    }
			    else {
	 		 		echo json_encode(array("id" => $_POST["book-id"], "updated" => true));
	 		 	}
	 		}
	 	}
 		#chiudere la connessione al DB 
 		mysqli_close($connection);
	}
?>
