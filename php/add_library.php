<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}

	if(isset($_POST["lib-name"])) {
		require_once('db_conn.php');

		$name = mysqli_real_escape_string($connection,$_POST["lib-name"]);
		$query = "INSERT INTO libreria(usr_id,nome) 
			      VALUES ('".$_SESSION["_bookclub_user_id"]."', '".$name."')";

		$result = mysqli_query($connection,$query);

		if($result) {
			echo json_encode(array('library_name' => $_POST["lib-name"], 'added_library' => true, 'library_id' => mysqli_insert_id($connection)));
			mysqli_close($connection);
		}
	}
?>