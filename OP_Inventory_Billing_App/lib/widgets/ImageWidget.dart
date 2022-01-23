import 'package:flutter/cupertino.dart';

Widget getImageAsset(String url, double height, double width) {
  return Container(
    width: width,
    height: height,
    child: Image.asset(
      url,
      fit: BoxFit.cover,
    ),
    margin: EdgeInsets.all(25.0),
  );
}
