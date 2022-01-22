import 'dart:io';
import 'package:flutter/material.dart';
import 'get_device_size.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final double? wordSpacing;
  final double? textScaleFactor;
  final TextAlign? textAlign;
  final int? lines;
  final String? fontFamily;

  const MyText({
    required this.text,
    this.size,
    this.fontWeight,
    this.fontColor,
    this.wordSpacing,
    this.textScaleFactor,
    this.textAlign,
    this.lines,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    double fontSize = screenSize.width<=600 ? screenSize.width / 26 : screenSize.width / 38;
    return Text(
      text.toString(),
      overflow: lines == 0 ? TextOverflow.visible : TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: lines == 0 ? null : lines,
      style: TextStyle(
          fontSize: size == null ? 15.0 :  fontSize + (screenSize.width<=600 ? size : size! * 1.6 + 1)!.toDouble() ,
          color: fontColor ?? Colors.black,
          fontFamily: Platform.isAndroid ? "Georgia" : " Sans Francisco",
          fontWeight: fontWeight ?? FontWeight.normal,
          decoration: TextDecoration.none
      ),
    );
  }
}



