import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/widgets/get_device_size.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<List<dynamic>> downloadJSON() async {
    // print("download json called");
    // const jsonEndpoint = "http://192.168.174.1/Op/getData.php";
    const jsonEndpoint =
        "http://192.168.0.105:80/php_workspace/inventory_app/get_notifications.php";
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

  // @override
  // void initState() {
  //   super.initState();
  //   downloadJSON();
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSize = GetDeviceSize.getDeviceSize(context);
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
                  : ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(
                            snapshot.data![index]['notification_message']
                                    .toString() +
                                ' for product id: ' +
                                snapshot.data![index]['product_id'].toString(),
                          ),
                          subtitle: Text(
                            snapshot.data![index]['notification_date'],
                          ),
                        );
                      },
                    )
              // Text(
              //     snapshot.data![0].toString(),
              //   )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
