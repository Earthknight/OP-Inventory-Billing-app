import 'package:flutter/material.dart';
import '../widgets/billing_card.dart';
import '../widgets/payement_card.dart';


class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);
  @override
  _BillingState createState() => _BillingState();
}
String name = 'Banana';
int cost = 256;
int discount = 1;
String time = DateTime.now().toString();
int items = 3;
class _BillingState extends State<BillingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:  [
            Expanded(
              child: Container(
                height: 560,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 1, itemBuilder: (BuildContext context, int index) {
                      return BillingCard(cost: cost, time: time, discount: discount, name: name, items: items,);
                }),
              ),
            ),
            PayementCard(cost:cost,time: time,items:items,),
          ],
        ),
      ),
    );
  }
}
