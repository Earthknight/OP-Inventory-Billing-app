import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import 'package:op_inventory_billing_app/screens/products/product_screen.dart';
import 'package:op_inventory_billing_app/widgets/TextFieldWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/dat_picker_text_Field.dart';
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
    print(id);
    int idNumber = int.parse(id);
    print(idNumber);
    int incrementedId = idNumber+1;
    return "P$incrementedId";

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
  TextEditingController dateTimeController = TextEditingController();
  DateTime isSelected = DateTime.now();
  bool isPerishableBool = false;

  @override
  void initState() {
    productNameController.text = widget.product.productName;
    productRatePerItemController.text = widget.product.productCost;
    sellingRatePerItemController.text = widget.product.sellingPrice;
    quantityController.text = widget.product.productInStock;
    discountPercentageController.text = widget.product.discount!;
    tgl = widget.product.expiryDate!;
    isPerishableBool = widget.product.isPerishAble ;
  }

  void addData() async {
    if (await addProductOrNot(productNameController.text) == false) {
      var productId = await getProductId();
      print(productId);
      // print("addData called");
      String id = productId;
      // var url = "http://192.168.174.1/Op/addData.php";
      var url = "http://192.168.1.104:8080/php_workspace/product/addData.php";
      // var url = "http://192.168.0.105:80/php_workspace/inventory_app/addData.php";
      await post(Uri.parse(url), body: {
        "productId": id,
        "productName": productNameController.text,
        "productCost": productRatePerItemController.text,
        "productInStock": sellingRatePerItemController.text,
        "sellingPrice": quantityController.text,
        "discount": discountPercentageController.text,
        "expiryDate": "$pilihTanggal",
        "isPerishAble": forIsPerishable(isPerishableBool),
      });
    }
  }

  void editData() async {
    // var url = "http://192.168.174.1/Op/addData.php";
    var url = "http://192.168.1.104:8080/php_workspace/product/editData.php";
    await post(Uri.parse(url), body: {
      "productId": widget.product.productId,
      "productName": productNameController.text,
      "productCost": productRatePerItemController.text,
      "productInStock": quantityController.text,
      "sellingPrice": sellingRatePerItemController.text,
      "discount": discountPercentageController.text,
      "expiryDate":"$tgl",
      "isPerishAble": forIsPerishable(isPerishableBool),
    });
  }
  String forIsPerishable(bool value){
    if (value == true){
      return "1";
    }
    return "0";
  }


  String pilihTanggal = '', labelText = '';
  DateTime tgl = DateTime.now();
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tgl,
        firstDate: DateTime(1992),
        lastDate: DateTime(2099));

    if (picked != null && picked != tgl) {
      setState(() {
        tgl = picked;
        pilihTanggal = DateFormat('yyyy-MM-dd kk:mm:ss').format(tgl);
            // DateFormat.yMd().format(tgl)
      });
    } else {}
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
                  height: 0.02 * screenHeight,
                ),
                MyText(
                  text: "PURCHASE RATE PER ITEM",
                  size: 3.0,
                ),
                MyTextField(productRatePerItemController, TextInputType.number,
                    "Enter the purchase rate per item", "Please Enter a value"),
                SizedBox(
                  height: 0.02 * screenHeight,
                ),
                MyText(
                  text: "SELLING RATE PER ITEM",
                  size: 3.0,
                ),
                MyTextField(sellingRatePerItemController, TextInputType.number,
                    "Enter the selling rate per item", "Please Enter a value"),
                SizedBox(
                  height: 0.02 * screenHeight,
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
                  height: 0.02 * screenHeight,
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
                isPerishableBool
                ? MyText(
                  text: "EXPIRY DATE",
                  size: 3.0,
                )
                : SizedBox(),
                isPerishableBool
                ?
                DateDropDown(
                  labelText: labelText,
                  valueText: DateFormat('yyyy-MM-dd kk:mm:ss').format(tgl),
                  // DateFormat.yMd().format(tgl),
                  valueStyle: valueStyle,
                  onPressed: () {
                    _selectedDate(context);
                  },
                )
                // MyDatePickerTextFormField(
                //   hintText: "Select Expiry Date",
                //     dateController: dateTimeController,
                //   lastDate: DateTime.now().add(Duration(days: 366)),
                //   firstDate: widget.product.expiryDate!,
                //   initialDate: DateTime.now().add(Duration(days: 1)),
                //   onDateChanged: (selectedDate) {
                //     setState(() {
                //       print(selectedDate);
                //       print(isSelected);
                //       isSelected = selectedDate;
                //     });
                //   },
                // )
                    : SizedBox(),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ), //SizedBox
                    MyText(
                      text: 'IS PERISHABLE?',
                      size: 3.0,
                    ), //Text
                    SizedBox(width: 10), //SizedBox
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
                        print(widget.product.productId);
                        print(productNameController.text);
                        print(productRatePerItemController.text);
                        print(quantityController.text);
                        print(sellingRatePerItemController.text);
                        print(discountPercentageController.text);
                        print("$pilihTanggal");
                        print(forIsPerishable(isPerishableBool));
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
