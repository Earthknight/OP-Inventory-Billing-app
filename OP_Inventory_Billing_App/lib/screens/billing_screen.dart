import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/model/billingsecond.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import '../widgets/billing_card.dart';
import '../widgets/payement_card.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);
  @override
  _BillingState createState() => _BillingState();
}

//dummy data which will be used in Billing card and Payment card

String itemName = 'Banana';
int discount = 1;
double singleSellingCost = 0;
double totalPurchasePrice = 0;
double discountPrice = (singleSellingCost -
    (singleSellingCost *
        discount /
        100)); //price logic when discount is applied
double totalSellingCost = discountPrice;
String time = DateTime.now().toString();
int items = 3;
int totalcost = 400;
String Billingid = '00001';

//
//This function's purpose was to increment a value by checking last value from database

List productsmap = [];

Future<List<Product>> fetchProdata() async {
  var url = Uri.parse("http://192.168.174.1/Op/fetchselectedproducts.php");
  var response = await http.post(url, body: {
    "productId":
        "P101", //insertdata function in database refer inserbilling.php file
  });
  if (response.statusCode == 200) {
    productsmap = json.decode(response.body);
    if (response.body.isEmpty) {
      fetchProdata();
      json.decode(response.body);
    }
    return productsmap.map((product) => Product.fromJson(product)).toList();
  } else {
    throw Exception('We were not able to successfully download the json data.');
  }
}

class _BillingState extends State<BillingScreen> {
  void calculate(List<Product> list) {
    double purchase = 0.0;
    double selling = 0.0;
    for (int i = 0; i < list.length; i++) {
      purchase += double.parse(list[i].productCost);
      selling += (double.parse(list[i].sellingPrice) -
          (double.parse(list[i].sellingPrice) *
              int.parse(list[i].discount!) /
              100));
    }
    totalPurchasePrice = purchase;
    totalSellingCost = selling;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 560,
                width: double.infinity,
                child: FutureBuilder<List<Product>>(
                    future: fetchProdata(),
                    builder: (context, snapshot) {
                      List<dynamic> billinglist = snapshot.data ?? [];
                      return ListView.builder(
                          itemCount: billinglist.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(productsid);
                            //sellingPrice
                            return BillingCard(
                              cost:
                                  double.parse(billinglist[index].sellingPrice),
                              time: time,
                              discount: int.parse(billinglist[index].discount),
                              itemName: billinglist[index].productName,
                              items:
                                  int.parse(billinglist[index].productInStock),
                            );
                          });
                    }),
              ),
            ),
            FutureBuilder<List<Product>>(
                future: fetchProdata(),
                builder: (
                  BuildContext context,
                  snapshot,
                ) {
                  List<Product> productid = snapshot.data ?? [];
                  calculate(productid);
                  return PayementCard(
                    time: time,
                    items: productid.length,
                    sellingPrice: totalSellingCost,
                    purchasePrice: totalPurchasePrice,
                    discount: discount,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
