<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}

	if(isset($_GET["q"])) {
		require_once('db_conn.php');

		$book_id = mysqli_real_escape_string($connection,$_GET["q"]);
		$query = 	"SELECT * 
					FROM libri_libreria
					JOIN libreria ON libri_libreria.id_libreria = libreria.lib_id
					WHERE libreria.usr_id = '".$_SESSION["_bookclub_user_id"]."' AND libri_libreria.id_libro = '".$book_id."'";

		$result = mysqli_query($connection,$query);

		if($result) {
			$num_rows = mysqli_num_rows($result);
			mysqli_close($connection);

			if($num_rows == 0) {
				echo json_encode(array("present" => false));
				exit;
			}
			else {
				echo json_encode(array("present" => true));
				exit;
			}
		}
	}
?>