import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import 'package:op_inventory_billing_app/screens/products/product_screen.dart';
import 'package:op_inventory_billing_app/widgets/TextFieldWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/dialogBoxWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';
import '../../tab_bar_screen.dart';

Future<bool> addProductOrNot(String productName) async {
  var list = await downloadJSON();
  for (int i = 0; i < list.length; i++) {
    if (productName == list[i].productName) {
      return true;
    }
  }
  return false;
}

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
  bool isPerishableBool = false;
  var selectedDate = null;

  @override
  void initState() {
    productNameController.text = widget.product.productName;
    productRatePerItemController.text = widget.product.productCost;
    sellingRatePerItemController.text = widget.product.sellingPrice;
    quantityController.text = widget.product.productInStock;
    discountPercentageController.text = widget.product.discount!;
    isPerishableBool = widget.product.isPerishAble;
    selectedDate = widget.product.expiryDate;
  }

  void addData() async {
    if (await addProductOrNot(productNameController.text) == false) {
      var productId = await getProductId();
      // print("addData called");
      String idnew = productId;
      print(idnew);
      // var url = "http://192.168.174.1/Op/addData.php";
      var url = "http://192.168.0.7/billing_inventory_php/addData2.php";
      // var url = "http://192.168.0.105:80/php_workspace/inventory_app/addData.php";
      await post(Uri.parse(url), body: {
        "productId": idnew,
        "productName": productNameController.text,
        "productCost": productRatePerItemController.text,
        "productInStock": sellingRatePerItemController.text,
        "sellingPrice": quantityController.text,
        "discount": discountPercentageController.text,
        "expiry_date": "$selectedDate",
        "isPerishAble": forIsPerishable(isPerishableBool)
      });
    }
  }

  void editData() async {
    print(widget.product.productId);
    print(productRatePerItemController.text);
    // var url = "http://192.168.174.1/Op/addData.php";
    var url = "http://192.168.0.7/billing_inventory_php/editData2.php";
    await post(Uri.parse(url), body: {
      "productId": widget.product.productId,
      "productName": productNameController.text,
      "productCost": productRatePerItemController.text,
      "productInStock": quantityController.text,
      "sellingPrice": sellingRatePerItemController.text,
      "discount": discountPercentageController.text,
      "expiry_date": "$selectedDate",
      "isPerishAble": forIsPerishable(isPerishableBool)
    });
  }

  String forIsPerishable(bool value){
    if (value == true){
      return "1";
    }
    return "0";
  }
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
        print(selectedDate);
      });
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
                  height: 0.02 * screenHeight,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ), //SizedBox
                    MyText(
                      text: 'IS PERISHABLE?',
                      size: 3.0,
                    ), //Text
                    SizedBox(width: 5), //SizedBox
                    Checkbox(
                      value: isPerishableBool,
                      onChanged: (value) {
                        setState(() {
                          print(isPerishableBool);
                          isPerishableBool = value!;
                          print(isPerishableBool);
                        });
                      },
                    ), //Checkbox
                  ], //<Widget>[]
                ),
                isPerishableBool
                    ? Row(
                  children: [
                    SizedBox(width: 5),
                    const MyText(
                      text: "EXPIRY DATE",
                      size: 3.0,
                    ),
                    const SizedBox(
                      width:40,
                    ),
                    Text(DateFormat('yyyy-MM-dd').format(selectedDate).toString(),style: TextStyle(
                      color: Colors.red,
                    ),)
                  ],
                ) : SizedBox(),
                isPerishableBool
                    ?   FlatButton(
                  onPressed: _presentDatePicker,
                  child: const Text(
                    'Select A Date',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: Theme.of(context).primaryColor,
                )
                    : SizedBox(),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorDark),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                      ),
                      child: MyText(
                        text: "Cancel",
                        textScaleFactor: 1.3,
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context);
                        });
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorDark),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                      ),
                      child: MyText(
                        text: widget.buttonTitle,
                        textScaleFactor: 1.3,
                      ),
                      onPressed: () async {
                        if (widget.buttonTitle == 'Add') {
                          addData();
                          if (await addProductOrNot(productNameController.text) ==
                              true) {
                            myDialogBox("Added Already","If you want to chnage anything, \nplease update it","OK",context);
                          } else {
                            await downloadJSON();
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return TabBarScreen();
                                    }));
                              });
                            }
                          }
                        } else {
                          print(2);
                          editData();
                          await downloadJSON();
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return TabBarScreen();
                                  }));
                            });
                          }
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
