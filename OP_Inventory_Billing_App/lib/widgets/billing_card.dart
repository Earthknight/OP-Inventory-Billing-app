import 'package:flutter/material.dart';
import'dart:core';
import 'TextWidget.dart';
class BillingCard extends StatelessWidget {
  const BillingCard({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyText(text: "Banana",size: 20,fontColor: Colors.black,fontWeight: FontWeight.bold,),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    MyText(text: "Rs200",size: 14,fontColor: Colors.black,fontWeight: FontWeight.bold,),
                    Padding(
                      padding: EdgeInsets.only(top: 4,left: 4),
                      child: MyText(text: "50%",size: 2,fontColor: Colors.red),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),MyText(text: DateTime.now().toString(),size: -1,fontColor: Colors.grey),
              ],
            ),
            Container(
              height: 80,
              width: 80,
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
              child: const Center(
                child:  MyText(text: '2',size: 18,fontColor: Colors.black,fontWeight: FontWeight.bold,),
              ),
              padding: const EdgeInsets.all(10),
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
