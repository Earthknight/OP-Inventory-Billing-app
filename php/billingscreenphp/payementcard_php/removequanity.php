<?php

include 'conn.php';

$productId = $_POST['productId'];
$quantity = $_POST['quantity'];

$sql=$conn->query("UPDATE products SET productInStock = productInStock - '".$quantity."' WHERE productId = '".$productId."'");

$result=array();

echo json_encode($result);

?> 

