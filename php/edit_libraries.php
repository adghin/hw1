<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}

	if(isset($_POST["lib_id"]) && isset($_POST["lib_name"])) {
		require_once('db_conn.php');

		$lib_name = mysqli_real_escape_string($connection,$_POST["lib_name"]);
		$lib_id = mysqli_real_escape_string($connection,$_POST["lib_id"]);

		$query = "UPDATE libreria
 		 			  SET nome = '".$lib_name."'
 		 			  WHERE lib_id = '".$lib_id."' AND usr_id = '".$_SESSION["_bookclub_user_id"]."'";

 		$result = mysqli_query($connection,$query);
 		if($result) {
 			echo json_encode(array("correctly_edited" => true));
 		}
 		else {
 			echo json_encode(array("correctly_edited" => false));
 		}

 		mysqli_close($connection);
	}
	if(isset($_POST["option"])) {
		if($_POST["option"] == "delete") {
			require_once('db_conn.php');

			$lib_id = mysqli_real_escape_string($connection,$_POST["lib_id"]);

			$query = "DELETE FROM libreria WHERE libreria.lib_id = '".$lib_id."' AND libreria.usr_id = '".$_SESSION["_bookclub_user_id"]."'";
			$result = mysqli_query($connection,$query);

			if($result) {
				echo json_encode(array("correctly_removed" => true));
			}
			else {
				echo json_encode(array("correctly_removed" => false));
			}

			mysqli_close($connection);
		}
	}

?>