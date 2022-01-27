import 'package:flutter/material.dart';
import 'package:op_inventory_billing_app/widgets/TextFieldWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductQRCodeDetailScreen extends StatelessWidget {
  const ProductQRCodeDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    final deviceSize = GetDeviceSize.getDeviceSize(context);
    final quantityTextEditingController = TextEditingController();
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
                  data: productId,
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
              MyTextField(
                quantityTextEditingController,
                TextInputType.number,
                'Enter the Quantity',
                'Please Enter a value',
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
                      onPressed: () {},
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
