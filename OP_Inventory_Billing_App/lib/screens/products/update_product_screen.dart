import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import 'package:op_inventory_billing_app/screens/products/product_screen.dart';
import 'package:op_inventory_billing_app/widgets/TextFieldWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';

import '../../tab_bar_screen.dart';

Future<String> getProductId() async {
  var list = await downloadJSON();
  String id = list[list.length - 1].productId.substring(1);
  int idNumber = int.parse(id);
  print("P${idNumber++}");
  return "P${idNumber++}";
}

class UpdateProductScreen extends StatefulWidget {
  final String appBarTitle;
  final Product product;
  final String buttonTitle;
  const UpdateProductScreen(
      {Key? key,
      required this.appBarTitle,
      required this.product,
      required this.buttonTitle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => UpdateProductScreenState();
}

class UpdateProductScreenState extends State<UpdateProductScreen> {
  double screenWidth = 0.0, screenHeight = 0.0;

  final _formKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productRatePerItemController = TextEditingController();
  TextEditingController sellingRatePerItemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();

  @override
  void initState() {
    productNameController.text = widget.product.productName;
    productRatePerItemController.text = widget.product.productCost;
    sellingRatePerItemController.text = widget.product.sellingPrice;
    quantityController.text = widget.product.productInStock;
    discountPercentageController.text = widget.product.discount!;
  }

  void addData() async {
    print("addData called");
    var productId = await getProductId();
    // print("addData called");
    String id = productId;
    // var url = "http://192.168.174.1/Op/addData.php";
    var url = "http://192.168.174.1/Op/addData.php";
    // var url = "http://192.168.0.105:80/php_workspace/inventory_app/addData.php";
    await post(Uri.parse(url), body: {
      "productId": id,
      "productName": productNameController.text,
      "productCost": productRatePerItemController.text,
      "productInStock": sellingRatePerItemController.text,
      "sellingPrice": quantityController.text,
      "discount": discountPercentageController.text
    });
  }

  void editData() async {
    print("editData called");
    // var url = "http://192.168.174.1/Op/addData.php";
    var url = "http://192.168.174.1/Op/editData.php";
    await post(Uri.parse(url), body: {
      "productId": widget.product.productId,
      "productName": productNameController.text,
      "productCost": productRatePerItemController.text,
      "productInStock": quantityController.text,
      "sellingPrice": sellingRatePerItemController.text,
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
        title: Center(
          child: MyText(
            text: widget.appBarTitle,
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
                MyTextField(productNameController, TextInputType.text,
                    "Enter the Product name", "Please Enter a value"),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "PURCHASE RATE PER ITEM",
                  size: 3.0,
                ),
                MyTextField(productRatePerItemController, TextInputType.number,
                    "Enter the purchase rate per item", "Please Enter a value"),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "SELLING RATE PER ITEM",
                  size: 3.0,
                ),
                MyTextField(sellingRatePerItemController, TextInputType.number,
                    "Enter the selling rate per item", "Please Enter a value"),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "QUANTITY",
                  size: 3.0,
                ),
                MyTextField(
                    quantityController,
                    TextInputType.number,
                    "Enter the Quantity of the product",
                    "Please Enter a value"),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                MyText(
                  text: "DISCOUNT PERCENTAGE",
                  size: 3.0,
                ),
                MyTextField(discountPercentageController, TextInputType.number,
                    "Enter the discount percentage", "Please Enter a value"),
                SizedBox(
                  height: 0.05 * screenHeight,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColorDark),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Theme.of(context).primaryColorLight)),
                  ),
                  child: MyText(
                    text: "Update",
                    textScaleFactor: 1.3,
                  ),
                  onPressed: () async {
                    if (widget.buttonTitle == 'Add') {
                      addData();
                    } else {
                      editData();
                    }
                    await downloadJSON();
                    if (_formKey.currentState!.validate()) {
                      print(sellingRatePerItemController.text);
                      print(productNameController.text);
                      print(productRatePerItemController.text);
                      print(discountPercentageController.text);
                      print(quantityController.text);
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
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
