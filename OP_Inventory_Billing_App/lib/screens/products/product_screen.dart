//http://192.168.174.1/billing_inventory_php/getData.php
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import 'package:op_inventory_billing_app/screens/products/product_qr_code_detail_screen.dart';
import 'package:op_inventory_billing_app/screens/products/update_product_screen.dart';
import 'package:op_inventory_billing_app/widgets/ListTileWidget.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

double screenWidth = 0.0;

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
            return UpdateProductScreen(
              buttonTitle: 'Add',
              appBarTitle: "Add a new product",
              product: Product(
                productId: '',
                productCost: '',
                productInStock: '',
                productName: '',
                sellingPrice: '',
                discount: '',
                expiryDate: DateTime.now(),
                isPerishAble: false,
              ),
            );
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
  var items = [
    //For dropdown menu
    '',
    'Purchase Price',
    'Selling Price',
    'Expiry Date',
  ];
  String dropdownvalue = '';
  @override
  Widget build(BuildContext context) {
    // print("Items called");
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemCount: widget.list.length,
        itemBuilder: (context, int index) {
          return listItem(widget.list[index], index, context);
        });
  }

  Widget dropdown(int i) {
    items[1] = 'Product Cost  ' + widget.list[i].productCost;
    items[2] = 'Selling Cost  ' + widget.list[i].sellingPrice;
    items[3] = widget.list[i].isPerishAble
        ? 'Expiry Date  ' +
            DateFormat('yyyy-MM-dd')
                .format(widget.list[i].expiryDate)
                .toString()
        : 'Not Perishable';
    //Dropdown menu created
    return DropdownButton(
      // Initial Value
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(
            items,
            style: TextStyle(fontSize: screenWidth * 0.02),
          ),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        //setState(() {
        dropdownvalue = newValue!;
        //});
      },
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
          isSoldOut: isSoldOut,
          title: GestureDetector(
              child: MyText(
                text: product.productName.toString(),
                fontColor: isSoldOut ? Colors.white : Colors.black,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateProductScreen(
                    buttonTitle: 'Update',
                    appBarTitle: "Update ${product.productName}",
                    product: product,
                  );
                }));
              }),
          subtitle: Row(
            children: [
              Text(
                'Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                child: dropdown(i),
                alignment: Alignment.centerRight,
                width: screenWidth * 0.33,
              )
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
            onTap: () {
              if (!isSoldOut) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ProductQRCodeDetailScreen(
                      productId: product.productId.toString(),
                      productName: product.productName.toString(),
                      productSellingPrice: product.sellingPrice.toString(),
                    ),
                  ),
                );
              }
            },
          ),
          trailing: GestureDetector(
              child: SizedBox(
                  height: screenWidth * 0.1,
                  width: screenWidth * 0.14,
                  child: Card(
                    elevation: 5.0,
                    child: Center(
                      child: MyText(
                        text: product.productInStock.toString(),
                        lines: 1,
                      ),
                    ),
                  )),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateProductScreen(
                    buttonTitle: 'Update',
                    appBarTitle: "Update ${product.productName}",
                    product: product,
                  );
                }));
              }),
        ),
      ),
    );
  }
}
