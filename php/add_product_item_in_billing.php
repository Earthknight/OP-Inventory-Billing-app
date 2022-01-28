<?php

include 'conn.php';
$product_id = $_POST['product_id'];
$product_quantity = $_POST['product_quantity'];

$conn->query("INSERT INTO `billing_cart` VALUES(null, $product_id,$product_quantity);")
?>