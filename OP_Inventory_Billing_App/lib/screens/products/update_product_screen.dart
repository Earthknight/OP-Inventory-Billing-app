import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import 'package:op_inventory_billing_app/widgets/TextFieldWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';

import '../../tab_bar_screen.dart';

int productid = 101;
class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);

  // final String appBarTitle;
  // final Product product;
  // const UpdateProductScreen({Key? key, required this.appBarTitle, required this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UpdateProductScreenState();
}

class UpdateProductScreenState extends State<UpdateProductScreen> {
  double screenWidth = 0.0, screenHeight = 0.0;

  final _formKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productRatePerItemController =
  TextEditingController();
  TextEditingController sellingRatePerItemController =
  TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController discountPercentageController =
  TextEditingController();

  @override
  void initState() {
    // productNameController = widget.product.productName as TextEditingController;
    // productRatePerItemController = widget.product.productCost as TextEditingController;
    // sellingRatePerItemController = widget.product.sellingPrice as TextEditingController;
    // quantityController = widget.product.productInStock as TextEditingController;
    // discountPercentageController = widget.product.discount as TextEditingController;
  }

  void addData() async {
    print("addData called");
    String id = "P${productid++}";
    print("id : $id");
    var url = "http://192.168.174.1/Op/addData.php";
  //  var url = "http://192.168.1.107:8080/php_workspace/product/addData.php";
    await post(Uri.parse(url),body: {
      "productId": id,
      "productName": productNameController.text,
      "productCost": productRatePerItemController.text,
      "productInStock":  sellingRatePerItemController.text,
      "sellingPrice": quantityController.text,
      "discount": discountPercentageController.text
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Center(
          child: MyText(
            text: "Update Product",
            fontWeight: FontWeight.bold,
            size: 10.0,
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.03, right: screenWidth * 0.03),
            child: ListView(
              children: [
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "PRODUCT NAME",
                  size: 3.0,
                ),
                MyTextField(
                 productNameController, TextInputType.text, "Enter the Product name" , "Please Enter a value"
                ),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "PURCHASE RATE PER ITEM",
                  size: 3.0,
                ),
                MyTextField(
                  productRatePerItemController, TextInputType.number, "Enter the purchase rate per item" , "Please Enter a value"
                ),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "SELLING RATE PER ITEM",
                  size: 3.0,
                ),
                MyTextField(
                  sellingRatePerItemController, TextInputType.number, "Enter the selling rate per item" , "Please Enter a value"
                ),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "QUANTITY",
                  size: 3.0,
                ),
                MyTextField(
                  quantityController, TextInputType.number, "Enter the Quantity of the product" , "Please Enter a value"
                ),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "DISCOUNT PERCENTAGE",
                  size: 3.0,
                ),
                MyTextField(
                  discountPercentageController, TextInputType.number, "Enter the discount percentage" , "Please Enter a value"
                ),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorDark),
                    textStyle: MaterialStateProperty.all(TextStyle(
                        color: Theme.of(context).primaryColorLight)),
                  ),
                  child: MyText(
                    text: "Update",
                    textScaleFactor: 1.3,
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      print(sellingRatePerItemController.text);
                      print(productNameController.text);
                      print(productRatePerItemController.text);
                      print(discountPercentageController.text);
                      print(quantityController.text);
                      setState(() {
                        addData();
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return TabBarScreen();
                        }));
                      });

                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
