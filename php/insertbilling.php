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
         && isset($_POST["billingtaxnum"]) && isset($_POST["items"]) && isset($_POST["billingamount"]);

  if($val){
       //checking if there is POST data

       $billingid = $_POST["billingid"]; //grabing the data from headers
       $billingdatetime = $_POST["billingdatetime"];
       $billingtaxnum = $_POST["billingtaxnum"];
       $items = $_POST["items"];
       $billingamount = $_POST["billingamount"];

       //validation name if there is no error before
       if($return["error"] == false && strlen($billingid) < 3){
           $return["error"] = true;
           $return["message"] = "Enter name up to 3 characters.";
       }

       //add more validations here

       //if there is no any error then ready for database write
       if($return["error"] == false){
            $billingid = mysqli_real_escape_string($link, $billingid);
            $billingdatetime = mysqli_real_escape_string($link, $billingdatetime);
            $billingtaxnum = mysqli_real_escape_string($link, $billingtaxnum);
            $items = mysqli_real_escape_string($link, $items);
            $billingamount = mysqli_real_escape_string($link, $billingamount);
            //escape inverted comma query conflict from string

            $sql = "INSERT INTO billing SET
                                BillingID = '$billingid',
                                BillingDateTime = '$billingdatetime',
                                BillingTaxNum = '$billingtaxnum',
                                Items = '$items',
	           BillingAmount = '$billingamount'";
	            
            //student_id is with AUTO_INCREMENT, so its value will increase automatically

            $res = mysqli_query($link, $sql);
            if($res){
                //write success
            }else{
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
