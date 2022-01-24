<?php

include 'conn.php';
$productId = $_POST['productId'];
$productName = $_POST['productName'];
$productCost = $_POST['productCost'];
$productInStock = $_POST['productInStock'];
$sellingPrice = $_POST['sellingPrice'];
$discount = $_POST['discount'];

$conn->query("insert into products(ProductId,ProductName,ProductCost,ProductinStock,SellingPrice,Discount) values('".$productId."','".$productName."','".$productCost."','".$productInStock."','".$sellingPrice."','".$discount."')")
?>