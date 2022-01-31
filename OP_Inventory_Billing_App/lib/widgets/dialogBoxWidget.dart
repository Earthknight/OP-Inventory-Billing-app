
import 'package:flutter/material.dart';

import '../tab_bar_screen.dart';
import 'TextWidget.dart';


void  myDialogBox(String title, String subtitle, String buttonTitle1, BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: MyText(text: title,fontWeight: FontWeight.w700,size: 10,),
        content: MyText(text: subtitle),
        actions: [
          // FlatButton(
          //   textColor: Colors.black,
          //   onPressed: () {},
          //   child: MyText(text: buttonTitle2),
          // ),
          FlatButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return TabBarScreen();
                  }));
            },
            child: MyText(text: buttonTitle1,fontColor: Colors.white,fontWeight: FontWeight.bold,),
          ),
        ],
      );
    },
  );
}