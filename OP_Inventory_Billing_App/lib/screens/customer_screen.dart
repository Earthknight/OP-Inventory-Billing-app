import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/widgets/ListTileWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';
import 'package:qr_flutter/qr_flutter.dart';

double screenWidth = 0.0;
List<Map<String, String>> order = [];
Future<List<Product>> downloadJSON() async {
  // print("download json called");

  // const jsonEndpoint = "http://192.168.1.109:8080/php_workspace/product/getData.php";
  const jsonEndpoint = "http://192.168.174.1/billing_inventory_php/getData.php";
  final response = await get(Uri.parse(jsonEndpoint));
  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    // print(products);
    return products.map((product) => Product.fromJson(product)).toList();
  } else {
    throw Exception('We were not able to successfully download the json data.');
  }
}

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    order = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // print(order);
            order = [];
            Navigator.of(context).pop(order);
          },
        ),
        title: Text("Purchase Items"),
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
        },
      ),
    );
  }
}

class Items extends StatefulWidget {
  List<Product> list;

  Items({Key? key, required this.list}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  void filterList(List<Product> list) {
    list.removeWhere((element) => int.parse(element.productInStock) == 0);
  }

  @override
  Widget build(BuildContext context) {
    filterList(widget.list);
    // print("Items called");
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            itemCount: widget.list.length,
            itemBuilder: (context, int index) {
              return listItem(widget.list[index], index, context);
            }),
        SizedBox(
          height: screenWidth * 0.08,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(order);
          },
          child: Text(
            'BUY NOW',
            style: TextStyle(fontSize: screenWidth * 0.06, color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
          ),
        ),
      ],
    );
  }

  Widget listItem(
    Product product,
    int i,
    BuildContext context,
  ) {
    bool isSoldOut = int.parse(product.productInStock) <= 0 ? true : false;
    return Padding(
      padding: EdgeInsets.only(top: screenWidth * 0.015),
      child: Card(
        elevation: 5.0,
        child: MyListTile(
          isSoldOut: false,
          title: GestureDetector(
              child: MyText(
                text: product.productName.toString(),
                fontColor: isSoldOut ? Colors.white : Colors.black,
              ),
              onTap: () {}),
          subtitle: Row(
            children: [
              Text(
                'Price   ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Container(
              //   child: dropdown(i),
              //   alignment: Alignment.centerRight,
              //   width: screenWidth * 0.33,
              // )
              Text(product.sellingPrice.toString())
            ],
          ),
          leading: GestureDetector(
            child: SizedBox(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              child: QrImage(
                data: product.productId.toString(),
                version: QrVersions.auto,
              ),
            ),
            onTap: () {},
          ),
          trailing: GestureDetector(
            child: SizedBox(
              height: screenWidth * 0.1,
              width: screenWidth * 0.14,
              child: Card(
                elevation: 5.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    if (int.parse(val) > 0) {
                      order.add({
                        'productId': product.productId,
                        'count': val,
                        'costPrice': product.productCost,
                        'sellingPrice': product.sellingPrice,
                        'discount': product.discount!
                      });
                    } else {
                      order.add({
                        'productId': product.productId,
                        'count': '0',
                        'costPrice': '0',
                        'sellingPrice': '0',
                        'discount': '0'
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
