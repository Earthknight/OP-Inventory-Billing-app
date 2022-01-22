import 'package:flutter/material.dart';

class GetDeviceSize {
  static Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}