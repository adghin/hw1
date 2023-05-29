<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}

	require_once('db_conn.php');

	$query = "SELECT nome,lib_id FROM libreria WHERE usr_id = '".$_SESSION["_bookclub_user_id"]."'";
	$result = mysqli_query($connection,$query);
	if($result) {
		$num_rows = mysqli_num_rows($result);
		if($num_rows == 0) {
			echo json_encode(null);
		}
		else {
			while($row = mysqli_fetch_row($result)) {
				$lib_names[] = $row;
			}
			mysqli_close($connection);
			for($i = 0; $i < count($lib_names); $i++) {
				$data[] = array("id" => $lib_names[$i][1], "name" => $lib_names[$i][0]);
			}
			echo json_encode($data);
		}
	} 
?>