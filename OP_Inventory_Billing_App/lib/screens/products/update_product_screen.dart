import 'package:flutter/material.dart';
import 'package:op_inventory_billing_app/widgets/TextFieldWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UpdateProductScreenState();
}

class UpdateProductScreenState extends State<UpdateProductScreen> {
  double screenWidth = 0.0, screenHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    TextEditingController productNameController = TextEditingController();
    TextEditingController productRatePerItemController =
        TextEditingController();
    TextEditingController sellingRatePerItemController =
        TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController discountPercentageController =
        TextEditingController();

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
                hintText: "Enter the Product Name",
                textController: productNameController,
              ),
              SizedBox(
                height: 0.05 * screenHeight,
              ),
              MyText(
                text: "PURCHASE RATE PER ITEM",
                size: 3.0,
              ),
              MyTextField(
                hintText: "Enter the purchase rate per item",
                textController: productRatePerItemController,
              ),
              SizedBox(
                height: 0.05 * screenHeight,
              ),
              MyText(
                text: "SELLING RATE PER ITEM",
                size: 3.0,
              ),
              MyTextField(
                hintText: "Enter the selling rate per item",
                textController: sellingRatePerItemController,
              ),
              SizedBox(
                height: 0.05 * screenHeight,
              ),
              MyText(
                text: "QUANTITY",
                size: 3.0,
              ),
              MyTextField(
                hintText: "Enter the Quantity of the product",
                textController: quantityController,
              ),
              SizedBox(
                height: 0.05 * screenHeight,
              ),
              MyText(
                text: "DISCOUNT PERCENTAGE",
                size: 3.0,
              ),
              MyTextField(
                hintText: "Enter the discount percentage",
                textController: discountPercentageController,
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
                  setState(() {

                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
