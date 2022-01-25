import 'package:flutter/material.dart';
import '../widgets/billing_card.dart';
import '../widgets/payement_card.dart';
import 'dart:math';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);
  @override
  _BillingState createState() => _BillingState();
}

String name = 'Banana';
int discount = 1;
double totalsellingcost = 256;
double singlesellingcost = 100;
double totalpurchasePrice = 256;
double discountprice =
    (singlesellingcost - (singlesellingcost * discount / 100));
String time = DateTime.now()
    .toString(); //dummy data which will be used in Billing car and Payement card
int items = 3;
int totalcost = 400;

//original_price - (original_price * discount / 100)
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
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return BillingCard(
                        cost: discountprice,
                        time: time,
                        discount: discount,
                        name: name,
                        items: items,
                      );
                    }),
              ),
            ),
            PayementCard(
                time: time,
                items: items,
                sellingPrice: totalsellingcost,
                purchasePrice: totalpurchasePrice,
                discount: discount),
          ],
        ),
      ),
    );
  }
}
