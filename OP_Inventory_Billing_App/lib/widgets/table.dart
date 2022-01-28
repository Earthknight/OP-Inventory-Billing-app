import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'dart:math';

import 'package:op_inventory_billing_app/model/billing.dart';

class SalesTable extends StatefulWidget {
  List<Billing> list;
  SalesTable({Key? key, required this.list}) : super(key: key);

  @override
  SalesTableState createState() => SalesTableState();
}

class SalesTableState extends State<SalesTable> {
  final HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortByBillingId =
      0; //True or false whether to sort by billing id or not
  static const int sortcountProducts = 1;
  bool isAscending = true; //ascending order
  int sortType = sortByBillingId; //Tells how to sort
  double h = 0.0;
  double w = 0.0;
  @override
  void initState() {
    //user.initData(1000);
    super.initState();
  }

  void sortBillingId(bool isAscending) {
    //A new list is created by sorting according to billing Id
    widget.list.sort((a, b) {
      //Compares items a and b according to the sorting function which we have created in the follwing LOC
      int aId = int.parse(a.billingId);
      int bId = int.parse(b.billingId);
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  void sortNoOfProducts(bool isAscending) {
    //A new list is created by sorting according to no of products
    widget.list.sort((a, b) {
      //Compares items a and b according to the sorting function which we have created in the follwing LOC
      int aId = a.items;
      int bId = b.items;
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Container(
      child: HorizontalDataTable(
        //Creates table
        leftHandSideColumnWidth: 0.25 * w, //first column only
        rightHandSideColumnWidth: 0.75 * w, //rest of columns
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(), //For titles widget
        leftSideItemBuilder:
            _generateFirstColumnRow, //Only for 1st column widget
        rightSideItemBuilder:
            _generateRightHandSideColumnRow, //For rest of columns widget
        itemCount: widget.list.length,
        rowSeparatorWidget: const Divider(
          //seperate rows using it
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Colors.white,
        rightHandSideColBackgroundColor: Colors.white,
        verticalScrollbarStyle: const ScrollbarStyle(
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        enablePullToRefresh: true,
        refreshIndicator: const WaterDropHeader(),
        refreshIndicatorHeight: 0.07 * h,
        onRefresh: () async {
          //refresh mechanism
          //Do sth
          await Future.delayed(const Duration(milliseconds: 500));
          _hdtRefreshController.refreshCompleted();
        },
        htdRefreshController:
            _hdtRefreshController, //wrapper controller for returning the refresh or load result.
      ),
      height: MediaQuery.of(context).size.height * 0.50,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Billing ID' +
                (sortType == sortByBillingId ? (isAscending ? '↓' : '↑') : ''),
            0.25 * w),
        onPressed: () {
          //print("Height is" + h.toString() + "Width is" + w.toString());
          sortType = sortByBillingId;
          isAscending =
              !isAscending; //On pressing we change ascending to descending order
          sortBillingId(isAscending);
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            'Number of Products' +
                (sortType == sortcountProducts
                    ? (isAscending ? '↓' : '↑')
                    : ''),
            0.25 * w),
        onPressed: () {
          sortType = sortcountProducts;
          isAscending = !isAscending;
          sortNoOfProducts(isAscending);
          setState(() {});
        },
      ),
      _getTitleItemWidget('Purchase Amount', 0.25 * w),
      _getTitleItemWidget('Selling Amount', 0.25 * w),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 0.07 * h,
      padding: EdgeInsets.fromLTRB(0.01 * w, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(widget.list[index].billingId),
      width: 0.25 * w,
      height: 0.06 * h,
      padding: EdgeInsets.fromLTRB(0.01 * w, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(widget.list[index].items.toString()),
          width: 0.25 * w,
          height: 0.06 * h,
          padding: EdgeInsets.fromLTRB(0.01 * w, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text('\u{20B9}' + widget.list[index].billingamount.toString()),
          width: 0.25 * w,
          height: 0.06 * h,
          padding: EdgeInsets.fromLTRB(0.01 * w, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text('\u{20B9}' + widget.list[index].sellingamount.toString()),
          width: 0.25 * w,
          height: 0.06 * h,
          padding: EdgeInsets.fromLTRB(0.01 * w, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
