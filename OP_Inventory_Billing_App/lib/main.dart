import 'package:flutter/material.dart';
import 'package:op_inventory_billing_app/tab_bar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory & Billing App',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.white,
      // ),
      home: const TabBarScreen(),
    );
  }
}
