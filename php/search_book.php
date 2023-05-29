<?php
	require_once('user_auth.php');
	if(!isAuth()) {
		header("Location: login.php");
		exit;
	}


	$query = $_GET["q"];
	$gbooks_key = 'AIzaSyD3UU0O6qQ3plwI3ydsAaR6PeAVY1yX6-Q';
	$gbooks_endpoint = 'https://www.googleapis.com/books/v1/volumes?';
	$max_results = 20;
	
	$param = array("q" => $query, "key" => $gbooks_key, "maxResults" => $max_results);
	$param = http_build_query($param);
	$headers = array("Content-Type: application/x-www-form-urlencoded");
	$url  = $gbooks_endpoint . $param;

	$curl = curl_init();
	curl_setopt($curl,CURLOPT_URL,$url);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($curl, CURLOPT_HTTPHEADER,$headers); 

	$res = curl_exec($curl);
	curl_close($curl);

	echo $res;
?>
