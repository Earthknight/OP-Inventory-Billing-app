<?php

include 'conn.php';
$productId = $_POST['productId'];
$productName = $_POST['productName'];
$productCost = $_POST['productCost'];
$productInStock = $_POST['productInStock'];
$sellingPrice = $_POST['sellingPrice'];
$discount = $_POST['discount'];
$expiry_date = $_POST['expiry_date'];
$isPerishAble = $_POST['isPerishAble'];

$conn->query("insert into products(productId,productName,productCost,productinStock,sellingPrice,discount,expiry_date,isPerishAble) values('".$productId."','".$productName."','".$productCost."','".$productInStock."','".$sellingPrice."','".$discount."','".$expiry_date."','".$isPerishAble."')")
?>