import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<ListTile> list = [];

  List<Map<String, dynamic>> productexpiry = [];
  Future<void> fetchProductIds() async {
    var url = Uri.parse(
        "http://192.168.0.7/billing_inventory_php/getData.php");
    final response = await get(url);
    if (response.statusCode == 200) {
      List productExpiry = json.decode(response.body);
      productexpiry = List.from(productExpiry);
    } else {
      throw Exception('No data found.');
    }
  }

  bool nearExpiry(List<dynamic> l) {
    list = [];
    for (int index = 0; index < l.length; index++) {
      list.add(ListTile(
        title: Text(
          l[index]['notification_message'].toString() +
              ' for product id: ' +
              l[index]['product_id'].toString(),
        ),
        subtitle: Text(
          l[index]['notification_date'],
        ),
      ));
    }

    for (int index = 0; index < productexpiry.length; index++) {
      DateTime date = DateFormat("yyyy-MM-dd hh:mm:ss")
          .parse(productexpiry[index]['expiry_date']!);
      if (date.isBefore(DateTime.now().add(const Duration(days: 10))) == true) {
        list.add(ListTile(
          title: Text(
            'Expiry Date is near for product id: ' +
                productexpiry[index]['productId'].toString(),
          ),
        ));
      }
    }
    return true;
  }

  Future<List<dynamic>> downloadJSON() async {
    const jsonEndpoint =
        "http://192.168.0.7/products_php_files/get_notifications.php";
    final response = await get(Uri.parse(jsonEndpoint));
    if (response.statusCode == 200) {
      List products = json.decode(response.body);
      return products;
      // return products.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception(
          'We were not able to successfully download the json data.');
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchProductIds();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = GetDeviceSize.getDeviceSize(context);
    fetchProductIds();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: downloadJSON(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) print(snapshot.hasError);

          return snapshot.hasData
              ? snapshot.data!.isEmpty
                  ? const Center(
                      child: Text('No Notifications'),
                    )
                  : nearExpiry(snapshot.data!)
                      ? ListView(
                          padding: const EdgeInsets.all(8),
                          children: list,
                        )
                      : ListView(
                          padding: const EdgeInsets.all(8),
                          children: list,
                        )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
