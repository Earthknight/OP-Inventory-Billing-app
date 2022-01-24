import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/model/billing.dart';
import '../model/products/product.dart';
import '../widgets/table.dart';

Future<List<Billing>> downloadJSON() async {
  // print("download json called");
  const jsonEndpoint = "http://192.168.174.1/Op/salesData.php";
  final response = await get(Uri.parse(jsonEndpoint));
  if (response.statusCode == 200) {
    List products = json.decode(response.body);
    // print(products);
    return products.map((product) => Billing.fromJson(product)).toList();
  } else {
    throw Exception('We were not able to successfully download the json data.');
  }
}

class SalesScreen extends StatefulWidget {
  SalesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  double h = 0.0, w = 0.0;
  double revenue = 0.0, profit = 0.0;
  
  void calc(List<Billing> list) {
    double sum = 0.0;
    double sp = 0.0;
    for (int i = 0; i < list.length; i++) {
      sum += list[i].billingamount;
      sp += list[i].sellingamount;
    }
    revenue = sum;
    profit = (sp - sum) / 100;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Container(
      padding: EdgeInsets.only(left: 0.03 * w),
      child: SingleChildScrollView(
        child: FutureBuilder<List<Billing>>(
          future: downloadJSON(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              print(snapshot.error);
            else if (snapshot.hasData) {
              calc(snapshot.data ?? []);
              return Padding(
                padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SalesTable(
                      list: snapshot.data ?? [],
                    ),
                    SizedBox(
                      height: 0.1 * h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0.1 * w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profit Percentage " + profit.toString(),
                            style: TextStyle(
                              fontSize: 0.03 * h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 0.05 * h,
                          ),
                          Text(
                            "Revenue:\u{20B9}" + revenue.toString(),
                            style: TextStyle(
                              fontSize: 0.03 * h,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
