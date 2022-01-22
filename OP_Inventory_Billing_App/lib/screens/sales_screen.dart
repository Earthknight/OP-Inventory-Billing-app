import 'package:flutter/material.dart';

import '../widgets/table.dart';

class SalesScreen extends StatefulWidget {
  SalesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  double h = 0.0, w = 0.0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Container(
      padding: EdgeInsets.only(left: 0.03 * w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SalesTable(),
            SizedBox(
              height: 0.1 * h,
            ),
            Container(
              padding: EdgeInsets.only(left: 0.1 * w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profit Percentage :20%",
                    style: TextStyle(
                      fontSize: 0.03 * h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 0.05 * h,
                  ),
                  Text(
                    "Revenue:\u{20B9}30000",
                    style: TextStyle(
                      fontSize: 0.03 * h,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
