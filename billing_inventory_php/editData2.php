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

$conn->query("update products set productName ='".$productName ."',productCost='".$productCost."',productInStock='".$productInStock."',sellingPrice='".$sellingPrice."',discount='".$discount."',expiry_date='".$expiry_date."',isPerishAble='".$isPerishAble."' where productId ='".$productId."'")
