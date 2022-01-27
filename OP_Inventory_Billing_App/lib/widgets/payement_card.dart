import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:op_inventory_billing_app/model/billingsecond.dart';
import 'package:op_inventory_billing_app/screens/billing_screen.dart';
import '../tab_bar_screen.dart';
import 'TextWidget.dart';
import 'package:http/http.dart' as http;


class PayementCard extends StatefulWidget {

  // int total = 250;    //Total amount
  final double sellingPrice;
  final double purchasePrice;
  final String time;
  final int items;
  final int discount;
  final List<Billings> billinglist;
  PayementCard(
      {required this.sellingPrice,required this.time, required this.items,required this.purchasePrice, required this.discount, required this.billinglist});

  @override
  State<PayementCard> createState() => _PayementCardState();
}

class _PayementCardState extends State<PayementCard> {


  String get Taxnumber {
    var list = List.generate(50, (index) => index + 1)..shuffle();    //get function to get taxnumber
    return list.take(5).join('');
  }

  String  get BillingId {
    if(widget.billinglist.isEmpty){
      int a = 1;
      print("empty");
      String BillingIdpad = a.toString().padLeft(5,'0');
      // print(BillingIdpad);                                //get function to get billing id
      return BillingIdpad;
    }else{
      String result = widget.billinglist.last.billingId.substring(1, 6);
      int a = int.parse(result) + 1;
      String BillingIdpad = a.toString().padLeft(5,'0');
      print(BillingIdpad);                                //get function to get billing id
      return BillingIdpad;
    }
  }

  Future<void> insertData() async {
    var url = Uri.parse("http://192.168.0.7/insertbilling.php");
     var response = await http.post(url, body: {
      "billingid": "B" +BillingId.toString(),                          //insertdata function in database refer inserbilling.php file
      "billingdatetime": widget.time.toString(),
      "billingtaxnum": Taxnumber.toString(),
      "items": widget.items.toString(),
      "sellingamount": widget.sellingPrice.toString(),
       "purchaseamount": widget.purchasePrice.toString(),
       "discount": widget.discount.toString()
    });
     if(response.statusCode == 200){
       print(response.body);
       if(response.body.isEmpty) {
         insertData();
         json.decode(response.body);
       }
     }else{
       print('error');
     }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var h = size.height;                        //mediaquery
    var w = size.width;
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 15),
        height: h/5,
        width: double.infinity,                       //parentcontainer
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
            const MyText(text: "Billing amount",size: 15,fontColor: Colors.black,fontWeight: FontWeight.bold,),     //billing amount text
            const SizedBox(
              height: 5,
            ),
             MyText(text: "Rs " + widget.sellingPrice.toString(),size: 10,fontColor: Colors.black,fontWeight: FontWeight.bold,),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 280,
              child: ElevatedButton(child: const MyText(text:'Pay'),style: ElevatedButton.styleFrom(
                primary: Colors.white70, // background
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),// foreground
              ),
                onPressed: () {
                  insertData();
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) =>  TabBarScreen()),
                  );//calls insertdata and increments a
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
