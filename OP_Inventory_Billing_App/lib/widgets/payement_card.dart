import 'package:flutter/material.dart';

import 'TextWidget.dart';

class PayementCard extends StatelessWidget {
  const PayementCard({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      height: 150,
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
          const MyText(text: "Rs200",size: 10,fontColor: Colors.black,fontWeight: FontWeight.bold,),
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
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
