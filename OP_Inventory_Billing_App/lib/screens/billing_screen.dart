import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/model/billingsecond.dart';
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
double singleSellingCost = 100;
double totalPurchasePrice = 256;
double discountPrice = (singleSellingCost - (singleSellingCost * discount/100)); //price logic when discount is applied
double totalSellingCost = discountPrice;
String time = DateTime.now().toString();
int items = 3;
int totalcost = 400;
String Billingid = '00001' ;
List<dynamic> billing = [];

//This function's purpose was to increment a value by checking last value from database
Future<List<Billings>> getbillingdata() async {
  const jsonEndpoint = "http://192.168.0.7/products_php_files/getbillingdata.php";
  final response = await get(Uri.parse(jsonEndpoint));
  if (response.statusCode == 200) {
    billing = json.decode(response.body);
    // print(billing[billing.length-1]['BillingID']);
    // print(billing.map((product) => Billings.fromJson(product as Map<String, dynamic>)).toList());

    // var billingid = billing.last['BillingID'];
    return billing.map((billing) => Billings.fromMap(billing)).toList();    //returns whole value
  } else {
    throw Exception('ERROR');
  }
}
class _BillingState extends State<BillingScreen> {
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
                child: ListView.builder(
                    itemCount: 1, itemBuilder: (BuildContext context, int index) {
                      // print(productsid);
                      return BillingCard(cost: discountPrice, time: time, discount: discount, itemName: itemName, items: items,);
                }),
              ),
            ),
            FutureBuilder<List<Billings>>(
              future: getbillingdata(),
              builder: (BuildContext context, snapshot,) {
                List<Billings> ? productid = snapshot.data;
                return PayementCard(time:time,items:items, sellingPrice: totalSellingCost, purchasePrice: totalPurchasePrice, discount: discount, billinglist: productid ?? []);
              }
            ),
          ],
        ),
      ),
    );
  }
}
