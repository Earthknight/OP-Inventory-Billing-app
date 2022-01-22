import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'dart:math';

class SalesTable extends StatefulWidget {
  SalesTable({Key? key}) : super(key: key);

  @override
  SalesTableState createState() => SalesTableState();
}

class SalesTableState extends State<SalesTable> {
  final HDTRefreshController _hdtRefreshController = HDTRefreshController();

  static const int sortBillingId = 0;
  static const int sortcountProducts = 1;
  bool isAscending = true;
  int sortType = sortBillingId;
  double h = 0.0;
  double w = 0.0;
  @override
  void initState() {
    user.initData(1000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 0.25 * w, //first column only
        rightHandSideColumnWidth: 0.75 * w, //rest of columns
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: user.userInfo.length,
        rowSeparatorWidget: const Divider(
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
                (sortType == sortBillingId ? (isAscending ? '↓' : '↑') : ''),
            0.25 * w),
        onPressed: () {
          //print("Height is" + h.toString() + "Width is" + w.toString());
          sortType = sortBillingId;
          isAscending = !isAscending;
          user.sortBillingId(isAscending);
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
          user.sortNoOfProducts(isAscending);
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
      child: Text(user.userInfo[index].billingid),
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
          child: Text(user.userInfo[index].countProducts),
          width: 0.25 * w,
          height: 0.06 * h,
          padding: EdgeInsets.fromLTRB(0.01 * w, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text('\u{20B9}' + user.userInfo[index].purchaseAmount),
          width: 0.25 * w,
          height: 0.06 * h,
          padding: EdgeInsets.fromLTRB(0.01 * w, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text('\u{20B9}' + user.userInfo[index].sellingAmount),
          width: 0.25 * w,
          height: 0.06 * h,
          padding: EdgeInsets.fromLTRB(0.01 * w, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

User user = User();

class User {
  List<UserInfo> userInfo = [];

  void initData(int size) {
    Random rng = new Random();
    for (int i = 0; i < size; i++) {
      userInfo.add(UserInfo("$i".padLeft(8, '0'), rng.nextInt(20).toString(),
          rng.nextInt(2000).toString(), rng.nextInt(3000).toString()));
    }
  }

  ///
  /// Single sort, sort Name's id
  void sortBillingId(bool isAscending) {
    userInfo.sort((a, b) {
      //Compares items a and b according to the sorting function which we have created in the follwing LOC
      int aId = int.parse(a.billingid);
      int bId = int.parse(b.billingid);
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  void sortNoOfProducts(bool isAscending) {
    userInfo.sort((a, b) {
      //Compares items a and b according to the sorting function which we have created in the follwing LOC
      int aId = int.parse(a.countProducts);
      int bId = int.parse(b.countProducts);
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }
}

class UserInfo {
  String billingid;
  //bool status;
  String countProducts;
  String purchaseAmount;
  String sellingAmount;

  UserInfo(this.billingid, this.countProducts, this.purchaseAmount,
      this.sellingAmount);
}
