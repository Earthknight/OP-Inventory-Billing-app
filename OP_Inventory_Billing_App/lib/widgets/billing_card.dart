import 'package:flutter/material.dart';
import'dart:core';
import 'TextWidget.dart';

class BillingCard extends StatelessWidget {

  final String  itemName;
  final double ? cost;
  final int ? discount;
  final String  time;
  final String items;

   BillingCard(
      {required this.itemName, required this.cost, required this.discount, required this.time, required this.items});
  @override
//Billing Card
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var h = size.height;
    var w = size.width;
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 10,top: 10,right: 0,bottom: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   MyText(text: itemName,size: 20,fontColor: Colors.black,fontWeight: FontWeight.bold,),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children:  [
                    MyText(text: "Rs " + ((cost! - (cost! * discount!/100)) * int.parse(items)).toString(),size: 14,fontColor: Colors.black,fontWeight: FontWeight.bold,),
                       Padding(
                      padding: EdgeInsets.only(top: 0.00 * h,left: 0.02 * w),
                      child: MyText(text: discount.toString() + "%",size: 1,fontColor: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),MyText(text: time,size: -1,fontColor: Colors.grey),
              ],
            ),
            SizedBox(
              width: w/42,
            ),
            Container(
              height: h/8,
              width: w/4,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 3.0, //extend the shadow
                      offset: Offset(
                        0,
                        5.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black26,
                    width: 1,
                  )),
              child:  Center(
                child:  MyText(text: items,size: 10,fontColor: Colors.black,fontWeight: FontWeight.bold,lines: 3,),
              ),
              padding: EdgeInsets.all(w/18),
            )
          ],
        ),
      ),
      elevation: 7,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
