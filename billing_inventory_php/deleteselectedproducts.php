<?php

include 'conn.php';

$sql=$conn->query("delete from billing_cart");

$result=array();

while($fetchdata=$sql->fetch_assoc()){

	$result[]=$fetchdata;
}


echo json_encode($result);

?> 