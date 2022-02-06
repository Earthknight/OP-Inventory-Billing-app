<?php
include 'conn.php';
$product_id = $_POST['product_id'];
$quantity = $_POST['quantity'];
$conn->query("insert into billing_cart (product_id, quantity) values('".$product_id."','".$quantity."');");
?>
