<?php
	require_once('db_conn.php');

	$query = 	"SELECT libro.id_libro,titolo,libro.autori,libro.cover,TRUNCATE(AVG(rating_libri.rate),2) AS rating_medio,COUNT(*) AS 			num_voti FROM rating_libri
				JOIN libro ON libro.id_libro = rating_libri.id_libro
				GROUP BY libro.id_libro
				ORDER BY num_voti DESC
				LIMIT 3";

	$result = mysqli_query($connection,$query);
	
	if($result) {
		$num_rows = mysqli_num_rows($result);
		if($num_rows == 0) {
			echo json_encode(array("no_winners" => true));
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