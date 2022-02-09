import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:op_inventory_billing_app/model/billing.dart';
import 'package:op_inventory_billing_app/screens/billing_screen.dart';
import '../tab_bar_screen.dart';
import 'TextWidget.dart';
import 'package:http/http.dart' as http;

var billingid;
var error;
var billlingdata;

Future<List<Billing2>> getbillingdata() async {
  const jsonEndpoint =
      "http://192.168.174.1/billing_inventory_php/getbillingdata.php";
  final response = await http.get(Uri.parse(jsonEndpoint));
  if (response.statusCode == 200) {
    List billing = await json.decode(response.body);
    return billing
        .map((billing) => Billing2.fromMap(billing))
        .toList(); //returns whole value
  } else {
    throw Exception('ERROR');
  }
}

class PayementCard extends StatefulWidget {
//Payementcard
  // int total = 250;    //Total amount
  final double sellingPrice;
  final double purchasePrice;
  final String time;
  final int items;
  final int discount;
  late final List productid;
  late final List quantity;
  PayementCard({
    required this.sellingPrice,
    required this.time,
    required this.items,
    required this.purchasePrice,
    required this.discount,
    required this.productid,
    required this.quantity,
  });

  @override
  State<PayementCard> createState() => _PayementCardState();
}

class _PayementCardState extends State<PayementCard> {
  String get Taxnumber {
    var list = List.generate(50, (index) => index + 1)
      ..shuffle(); //get function to get taxnumber
    return list.take(5).join('');
  }

  Future<void> deletedata() async {
    var url = Uri.parse(
        "http://192.168.174.1/billing_inventory_php/deleteselectedproducts.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      productsmap = json.decode(response.body);
      if (response.body.isEmpty) {
        json.decode(response.body);
      }
    } else {
      throw Exception('Failed.');
    }
  }

  Future<void> updatePro() async {
    var url = Uri.parse(
        "http://192.168.174.1/billing_inventory_php/removequanity.php");
    for (int i = 0; i < widget.productid.length; i++) {
      var response = await http.post(url, body: {
        "productId": widget.productid[i]
            .toString(), //insertdata function in database refer inserbilling.php file
        "quantity": widget.quantity[i].toString(),
      });
      if (response.statusCode == 200) {
        // print(response.body);
        error = json.decode(response.body);
        print(error);
      } else {
        print('error');
      }
    }
  }

  String BillingIdnew(List<Billing2> l) {
    if (l.isEmpty) {
      int a = 1;
      print("empty");
      String BillingIdpad = a.toString().padLeft(5, '0');
      // print(BillingIdpad);                                //get function to get billing id
      return BillingIdpad;
    } else {
      String result = l.last.billingId.substring(1, 6);
      int a = int.parse(result) + 1;
      String BillingIdpad = a.toString().padLeft(5, '0');
      print(BillingIdpad); //get function to get billing id
      return BillingIdpad;
    }
  }

  Future<void> insertData(List<Billing2> l) async {
    print(widget.purchasePrice.toString());
    var url = Uri.parse(
        "http://192.168.174.1/billing_inventory_php/insertbilling.php");
    var response = await http.post(url, body: {
      "billingid": "B" +
          BillingIdnew(l)
              .toString(), //insertdata function in database refer inserbilling.php file
      "billingdatetime": widget.time.toString(),
      "billingtaxnum": Taxnumber.toString(),
      "items": widget.items.toString(),
      "sellingamount": widget.sellingPrice.toString(),
      "purchaseamount": widget.purchasePrice.toString(),
      "discount": widget.discount.toString()
    });
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isEmpty) {
        insertData(l);
        json.decode(response.body);
      }
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var h = size.height; //mediaquery
    var w = size.width;
    return FutureBuilder<List<Billing2>>(
        future: getbillingdata(),
        builder: (context, snapshot) {
          billlingdata = snapshot.data ?? [];
          print(snapshot.data ?? []);
          return Center(
            child: Container(
              padding: EdgeInsets.only(left: 15),
              height: h / 5,
              width: double.infinity, //parentcontainer
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black26,
                    width: 1,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyText(
                    text: "Billing amount",
                    size: 15,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), //billing amount text
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    text: "Rs " + widget.sellingPrice.toString(),
                    size: 10,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 280,
                    child: ElevatedButton(
                      child: const MyText(text: 'Pay'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white70, // background
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ), // foreground
                      ),
                      onPressed: () {
                        insertData(snapshot.data ?? []);
                        updatePro();
                        deletedata();
                        BillingScreen();
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => TabBarScreen()),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
