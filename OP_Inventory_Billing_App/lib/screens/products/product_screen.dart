import 'package:flutter/material.dart';
import 'package:op_inventory_billing_app/screens/products/update_product_screen.dart';
import 'package:op_inventory_billing_app/widgets/ImageWidget.dart';
import 'package:op_inventory_billing_app/widgets/ListTileWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen>{
  double screenWidth = 0.0;
  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    screenWidth = screenSize.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: screenWidth*0.03, right: screenWidth*0.03),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, int index) {
              return listItem("Apple", "20", "100");
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white, size: screenWidth*0.075,),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UpdateProductScreen();
          }));
        },

      ),
    );
  }

  Widget listItem(String name, String cost , String quantity){
    return Padding(
      padding: EdgeInsets.only(top: screenWidth*0.015),
      child: Card(
        elevation: 5.0,
        child: MyListTile(
          title: MyText(text: name,),
          subtitle: MyText(text: "Rs $cost",),
          leading: SizedBox(
            height:screenWidth*0.1,
              width: screenWidth*0.1,
              child:QrImage(
                data: "1234567890",
                version: QrVersions.auto,
              ),
          ),
          trailing: SizedBox(
            height:screenWidth*0.1,
            width: screenWidth*0.1,
            child: Card(
              elevation: 5.0,
              child: Center(
                child: MyText(text: quantity,),
              ),
            ),
          )
        ),
      ),
    );
  }
}
