import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import 'package:op_inventory_billing_app/screens/products/update_product_screen.dart';
import 'package:op_inventory_billing_app/widgets/ListTileWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';
import 'package:qr_flutter/qr_flutter.dart';

double screenWidth = 0.0;

Future<List<Product>> downloadJSON() async {
  // print("download json called");
  const jsonEndpoint =
      "http://192.168.1.107:8080/php_workspace/product/getData.php";
  final response = await get(Uri.parse(jsonEndpoint));
  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    // print(products);
    return products.map((product) => Product.fromJson(product)).toList();
  } else {
    throw Exception('We were not able to successfully download the json data.');
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    screenWidth = screenSize.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: screenWidth * 0.075,
          ),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UpdateProductScreen();
            }));
          },
        ),
        body: FutureBuilder<List<Product>>(
            future: downloadJSON(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.03, right: screenWidth * 0.03),
                      child: Items(
                        list: snapshot.data ?? [],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}

class Items extends StatelessWidget {
  List<Product> list;

  Items({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("Items called");
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, int index) {
          return listItem(list[index]);
        });
  }

  Widget listItem(Product product) {
    return Padding(
      padding: EdgeInsets.only(top: screenWidth * 0.015),
      child: Card(
        elevation: 5.0,
        child: MyListTile(
            title: MyText(
              text: product.productName.toString(),
            ),
            subtitle: MyText(
              text: "Rs ${product.productCost.toString()}",
            ),
            leading: SizedBox(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              child: QrImage(
                data: product.productId.toString(),
                version: QrVersions.auto,
              ),
            ),
            trailing: SizedBox(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              child: Card(
                elevation: 5.0,
                child: Center(
                  child: MyText(
                    text: product.productCost.toString(),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}