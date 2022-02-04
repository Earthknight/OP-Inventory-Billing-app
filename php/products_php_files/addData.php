<?php

include 'conn.php';
$productId = $_POST['productId'];
$productName = $_POST['productName'];
$productCost = $_POST['productCost'];
$productInStock = $_POST['productInStock'];
$sellingPrice = $_POST['sellingPrice'];
$discount = $_POST['discount'];
$expiryDate = $_POST['expiryDate'];
$isPerishAble = $_POST['isPerishAble'];

$conn->query("insert into products(productId,productName,productCost,productinStock,sellingPrice,discount,expiryDate,isPerishAble) values('".$productId."','".$productName."','".$productCost."','".$productInStock."','".$sellingPrice."','".$discount."','".$expiryDate."','".$isPerishAble."')")
?>