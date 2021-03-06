import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/widgets/TextFieldWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';
import 'package:qr_flutter/qr_flutter.dart';

final quantityTextEditingController = TextEditingController();

class ProductQRCodeDetailScreen extends StatefulWidget {
  const ProductQRCodeDetailScreen({
    Key? key,
    required this.productId,
    required this.productName,
    required this.productSellingPrice,
  }) : super(key: key);

  final String productId;
  final String productName;
  final String productSellingPrice;

  @override
  State<ProductQRCodeDetailScreen> createState() =>
      _ProductQRCodeDetailScreenState();
}

class _ProductQRCodeDetailScreenState extends State<ProductQRCodeDetailScreen> {
  Future<void> addBillingItemInCart(int productQuantity) async {
    var url =
        "http://192.168.174.1/billing_inventory_php/add_product_item_in_billing.php";
    await post(Uri.parse(url), body: {
      "product_id": widget.productId,
      "quantity": productQuantity.toString(),
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: const Text("Continue"),
      onPressed: () {
        addBillingItemInCart(
          int.parse(quantityTextEditingController.text),
        );
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure?"),
      content: Text(
        "Selling Price of the item " +
            widget.productName +
            " is " +
            widget.productSellingPrice,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = GetDeviceSize.getDeviceSize(context);
    // final quantityTextEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan the QR Code',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: deviceSize.height * 0.45,
                width: deviceSize.width * 0.6,
                child: QrImage(
                  data: widget.productId,
                  version: QrVersions.auto,
                ),
              ),
              const MyText(
                text: "Quantity",
                size: 3.0,
              ),
              SizedBox(
                height: deviceSize.height * 0.005,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: TextField(
              //     controller: quantityTextEditingController,
              //     keyboardType: TextInputType.number,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Enter the Quantity',
              //       hintText: 'Please Enter a value',
              //     ),
              //   ),
              // ),
              MyTextField(
                quantityTextEditingController,
                TextInputType.text,
                // decoration: const InputDecoration(
                //   border: InputBorder.none,
                'Enter the Quantity',
                'Please Enter a value',
                // ),
              ),
              SizedBox(
                height: deviceSize.height * 0.025,
              ),
              Container(
                width: deviceSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        // print(quantityTextEditingController.text);
                        // addBillingItemInCart(
                        //   int.parse(quantityTextEditingController.text),
                        // );

                        showAlertDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: deviceSize.width * 0.3,
                        child: const Text(
                          'Done',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: deviceSize.width * 0.3,
                        padding: const EdgeInsets.all(15),
                        child: const Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
