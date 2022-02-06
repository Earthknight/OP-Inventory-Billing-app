<?php

include 'conn.php';

$productId = $_POST['productId'];

$sql=$conn->query("select * from products where ProductId = '".$productId."'");

$result=array();

while($fetchdata=$sql->fetch_assoc()){

	$result[]=$fetchdata;
}


echo json_encode($result);

?> 