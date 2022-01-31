import 'package:flutter/material.dart';
import 'package:op_inventory_billing_app/screens/billing_screen.dart';
import 'package:op_inventory_billing_app/screens/notifications_screen.dart';
import 'package:op_inventory_billing_app/screens/sales_screen.dart';
import 'package:op_inventory_billing_app/screens/products/product_screen.dart';
import 'package:op_inventory_billing_app/widgets/TextWidget.dart';
import 'package:op_inventory_billing_app/widgets/table.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TabBarState();
}

class TabBarState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);

    _controller?.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
      print("Selected Index: " + _controller!.index.toString());
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: [
                PopupMenuButton(
                  // on selecting the notifications option this code gets
                  // executed and the user lands on notification screen
                  onSelected: (result) {
                    if (result == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const NotificationScreen(),
                        ),
                      );
                    }
                  },
                  itemBuilder: (_) => [
                    // option 1 i.e. notifications
                    const PopupMenuItem(
                      child: Text('Notifications'),
                      value: 0, // setting the value to 0
                    ),
                  ],
                  // icon for verticle 3 dots
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              title: const Center(
                child: MyText(
                  text: "Inventory & Billing",
                  fontWeight: FontWeight.bold,
                  size: 11.0,
                ),
              ),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicatorColor: Colors.grey,
                controller: _controller!,
                // isScrollable: true,
                tabs: [
                  Tab(child: MyText(text: "Products")),
                  Tab(child: MyText(text: "Billing")),
                  Tab(child: MyText(text: "Sales")),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller!,
          children: <Widget>[ProductScreen(), BillingScreen(), SalesScreen()],
        ),
      )),
    );
    ;
  }
}
