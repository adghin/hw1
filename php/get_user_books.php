<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}

	require_once('db_conn.php');

	if(isset($_POST["lib_id"])) {
		$lib_id = mysqli_real_escape_string($connection,$_POST["lib_id"]);
		$query = "SELECT L1.id_libro,L1.titolo,L1.autori,L1.cover,L4.rate,L5.id_libreria,L6.nome,L6.usr_id
					FROM libro AS L1
					JOIN libri_libreria L5 
					ON L1.id_libro = L5.id_libro
					JOIN libreria L6
					ON L6.lib_id = L5.id_libreria
					LEFT JOIN rating_libri L4
					ON L5.id_libro = L4.id_libro AND L4.id_user = L6.usr_id
					WHERE L1.id_libro IN (SELECT L2.id_libro FROM libri_libreria AS L2
										  WHERE L2.id_libreria IN 
										  (SELECT L3.lib_id FROM libreria AS L3 
										  WHERE L3.usr_id = '".$_SESSION["_bookclub_user_id"]."' AND L3.lib_id = '".$lib_id."')
										  )
					AND L6.usr_id = '".$_SESSION["_bookclub_user_id"]."'";
	}
	else {
		$query = 	"SELECT L1.id_libro,L1.titolo,L1.autori,L1.cover,L4.rate,L5.id_libreria,L6.nome,L6.usr_id
					FROM libro AS L1
					JOIN libri_libreria L5 
					ON L1.id_libro = L5.id_libro
					JOIN libreria L6
					ON L6.lib_id = L5.id_libreria
					LEFT JOIN rating_libri L4
					ON L5.id_libro = L4.id_libro AND L4.id_user = L6.usr_id
					WHERE L1.id_libro IN (SELECT L2.id_libro FROM libri_libreria AS L2
										  WHERE L2.id_libreria IN 
										  (SELECT L3.lib_id FROM libreria AS L3 
										  WHERE L3.usr_id = '".$_SESSION["_bookclub_user_id"]."')
										  )
					AND L6.usr_id = '".$_SESSION["_bookclub_user_id"]."'";
	}

	$result = mysqli_query($connection,$query);

	if($result) {
		$num_rows = mysqli_num_rows($result);

		if($num_rows == 0) {
			echo json_encode(null);
			exit;
		}
		else {
			$data = array();
			while($row = mysqli_fetch_assoc($result)) {
				$data[] = $row;
			}

			mysqli_close($connection);
			echo json_encode($data);
		}	
	}
?>