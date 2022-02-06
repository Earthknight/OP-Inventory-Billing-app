<?php

include 'conn.php';
//$product_id = $_POST['product_id'];
//$product_quantity = $_POST['product_quantity'];
//$conn->query("INSERT INTO `billing_cart` VALUES(null, $product_id,$product_quantity);")
$sql=$conn->query("select * from billing_cart");

$result=array();

while($fetchdata=$sql->fetch_assoc()){

	$result[]=$fetchdata;
}


echo json_encode($result);

?>