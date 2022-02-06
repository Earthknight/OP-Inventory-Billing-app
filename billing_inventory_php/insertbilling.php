<?php 
  $db = "productsales"; //database name
  $dbuser = "root"; //database username
  $dbpassword = "root"; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["message"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);
  //connecting to database server

  $val = isset($_POST["billingid"]) && isset($_POST["billingdatetime"])
         && isset($_POST["billingtaxnum"]) && isset($_POST["items"]) && isset($_POST["sellingamount"]) && isset($_POST["purchaseamount"]) && isset($_POST["discount"]);

  if($val){
       //checking if there is POST data

       $billingid = $_POST["billingid"]; //grabing the data from headers
       $billingdatetime = $_POST["billingdatetime"];
       $billingtaxnum = $_POST["billingtaxnum"];
       $items = $_POST["items"];
       $sellingamount = $_POST["sellingamount"];
       $purchaseamount = $_POST["purchaseamount"];
       $discount = $_POST["discount"];

       //validation name if there is no error before

       //add more validations here

       //if there is no any error then ready for database write
       if($return["error"] == false){
            $billingid = mysqli_real_escape_string($link, $billingid);
            $billingdatetime = mysqli_real_escape_string($link, $billingdatetime);
            $billingtaxnum = mysqli_real_escape_string($link, $billingtaxnum);
            $items = mysqli_real_escape_string($link, $items);
            $sellingamount = mysqli_real_escape_string($link, $sellingamount);
            $purchaseamount = mysqli_real_escape_string($link, $purchaseamount);
            $discount = mysqli_real_escape_string($link, $discount);
            //escape inverted comma query conflict from string

            $sql = "INSERT INTO billing SET
                                BillingID = '$billingid',
                                BillingDateTime = '$billingdatetime',
                                BillingTaxNum = '$billingtaxnum',
                                Items = '$items',
	           SellingAmount = '$sellingamount',
	           PurchaseAmount = '$purchaseamount',
	           Discount = '$discount'";
	            

            $res = mysqli_query($link, $sql);
            if($res){
                //write success
            }else{
                $res = mysqli_query($link, $sql);
                $return["error"] = true;
                $return["message"] = "Database error";
            }
       }
  }else{
      $return["error"] = true;
      $return["message"] = 'Send all parameters.';
  }

  mysqli_close($link); //close mysqli

  header('Content-Type: application/json');
  // tell browser that its a json data
  echo json_encode($return);
  //converting array to JSON string
?>