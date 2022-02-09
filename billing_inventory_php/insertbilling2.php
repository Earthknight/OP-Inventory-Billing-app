<?php

include 'conn.php';
$billingid = $_POST["billingid"]; //grabing the data from headers
$billingdatetime = $_POST["billingdatetime"];
$billingtaxnum = $_POST["billingtaxnum"];
$items = $_POST["items"];
$sellingamount = $_POST["sellingamount"];
$purchaseamount = $_POST["purchaseamount"];
$discount = $_POST["discount"];

$conn->query("insert into billing(BillingID,BillingDateTime,BillingTaxNum,Items,SellingAmount,PurchaseAmount,Discount) values('".$billingid."','".$billingdatetime."','".$billingtaxnum."','".$items."','".$sellingamount."','".$purchaseamount."','".$discount."')")
?>