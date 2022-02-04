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


$conn->query("update products set productName ='".$productName ."',productCost='.$productCost.',productInStock='.$productInStock.',sellingPrice='.$sellingPrice.',discount='.$discount.',expiryDate='.$expiryDate.',isPerishAble='.$isPerishAble.' where productId ='".$productId."'")
?>