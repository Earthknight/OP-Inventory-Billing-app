import 'dart:convert';
import 'package:flutter/material.dart';
import 'TextWidget.dart';
import 'package:http/http.dart' as http;


class PayementCard extends StatelessWidget {
  int total = 250;
  final int cost;
  final String time;
  final int items;
  PayementCard(
      {required this.cost,required this.time, required this.items});

  String get Taxnumber {
    var list = List.generate(50, (index) => index + 1)..shuffle();
    return list.take(5).join('');
  }
  int a = 1;
  List l = [];
  String  get BillingId {
    String BillingIdpad = a.toString().padLeft(5,'0');
    print(BillingIdpad);
    return BillingIdpad;
  }
  Future<void> insertData() async {
    var url = Uri.parse("http://192.168.0.7/insertbilling.php");
     var response = await http.post(url, body: {
      "billingid": BillingId.toString(),
      "billingdatetime": time.toString(),
      "billingtaxnum": Taxnumber.toString(),
      "items": items.toString(),
      "billingamount": cost.toString()
    });
     if(response.statusCode == 200){
       print(response.body);
       if(response.body.isNotEmpty) {
         json.decode(response.body);
       }
     }else{
       print('error');
     }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var h = size.height;
    var w = size.width;
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 15),
        height: h/5,
        width: double.infinity,
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
            const MyText(text: "Billing amount",size: 15,fontColor: Colors.black,fontWeight: FontWeight.bold,),
            const SizedBox(
              height: 5,
            ),
             MyText(text: "Rs " + total.toString(),size: 10,fontColor: Colors.black,fontWeight: FontWeight.bold,),
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
                   a++;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
