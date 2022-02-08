import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/screens/customer_screen.dart';
import '../model/products/product.dart';
import '../widgets/table.dart';
import 'package:intl/intl.dart';
import 'package:op_inventory_billing_app/model/billing.dart';
import '../model/billing.dart';
import 'package:http/http.dart' as http;

List<Map<String, String>> order = [];
int totalPurchasePrice = 0;
int totalSellingCost = 0;

///var products = [];
//List productsIDs = [];
//List productsQuantity = [];
List<Billing2> billingdata = [];
// List productsmapsecond = [];
// List<Product> productlist = [];

class SalesScreen extends StatefulWidget {
  SalesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  double h = 0.0, w = 0.0; //height and width
  double revenue = 0.0, profit = 0.0;
  List<Billing2> curr = []; //current list to be displayed
  List<Billing2> disp = []; //temporary empty list created for use in function
  var items = [
    //For dropdown menu
    '',
    'Day',
    'Week',
    'Month',
    'Year',
  ];
  String dropdownvalue = ''; //Selected dropdown menu value

  Future<List<Billing2>> downloadJSON() async {
    // print("download json called");
    const jsonEndpoint =
        "http://192.168.174.1/billing_inventory_php/salesData.php"; //Acces the php file on local system
    final response = await get(Uri.parse(jsonEndpoint)); //Send get request
    if (response.statusCode == 200) {
      //success confirmation
      List products =
          json.decode(response.body); //convert json to list of Billing products
      curr = products
          .map((product) => Billing2.fromMap(product))
          .toList(); //Converting the list into a suitable format using fromJSon from billing.dart
      return curr;
    } else {
      throw Exception(
          'We were not able to successfully download the json data.');
    }
  }

  double calcrevenue(List<Billing2> list) {
    //Calculating revenue
    double sum = 0.0;
    for (int i = 0; i < list.length; i++) {
      sum += list[i].purchaseAmount;
    }
    revenue = sum;
    return revenue;
  }

  double calcprofit(List<Billing2> list) {
    //Calculate profit
    double sum = 0.0;
    double sp = 0.0;
    for (int i = 0; i < list.length; i++) {
      sum += list[i].purchaseAmount;
      sp += list[i].sellingAmount;
    }
    profit = ((sp - sum) / sum) * 100;
    return profit;
  }

  List<Billing2> updateList(String option) {
    //Updates list according to dropdown value ie option and returns a new list
    if (option == "") {
      return curr;
    }
    if (option == "Day") {
      disp = []; //Empty the disp because it might contain some existing entries
      for (int i = 0; i < curr.length; i++) {
        if (DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(curr[i].billingDateTime)) ==
            DateFormat('yyyy-MM-dd').format(DateTime.now())) {
          disp.add(curr[i]);
        }
      }
      curr = List.from(
          disp); //Copy disp into current list which we will be returning
      return curr;
    }
    if (option == "Month") {
      disp = [];
      for (int i = 0; i < curr.length; i++) {
        if ((DateTime.parse(curr[i].billingDateTime).month ==
                DateTime.now().month) &&
            (DateTime.parse(curr[i].billingDateTime).year ==
                DateTime.now().year)) {
          disp.add(curr[i]);
        }
      }
      curr = List.from(disp);
      return curr;
    }
    if (option == "Year") {
      disp = [];
      for (int i = 0; i < curr.length; i++) {
        if (DateTime.parse(curr[i].billingDateTime).year ==
            DateTime.now().year) {
          disp.add(curr[i]);
        }
      }
      curr = List.from(disp);
      return curr;
    }
    if (option == "Week") {
      disp = [];
      for (int i = 0; i < curr.length; i++) {
        if (DateTime.parse(curr[i].billingDateTime)
            .isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
          disp.add(curr[i]);
        }
      }
      curr = List.from(disp);
      return curr;
    }
    return curr;
  }

  Widget dropdown() {
    //Dropdown menu created
    return DropdownButton(
      // Initial Value
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }

  Future<void> updatePro() async {
    var url = Uri.parse(
        "http://192.168.174.1/billing_inventory_php/removequanity.php");
    for (int i = 0; i < order.length; i++) {
      var response = await http.post(url, body: {
        "productId": order[i]["productId"]
            .toString(), //insertdata function in database refer inserbilling.php file
        "quantity": order[i]["count"],
      });
      if (response.statusCode == 200) {
        // print(response.body);
        var error = json.decode(response.body);
        print(error);
      } else {
        print('error');
      }
    }
  }

  String BillingIdnew(List<Billing2> l) {
    if (l.isEmpty) {
      int a = 1;
      // print("empty");
      String BillingIdpad = a.toString().padLeft(5, '0');
       //print(BillingIdpad);                                //get function to get billing id
      return BillingIdpad;
    } else {
      String result = l.last.billingId.substring(1, 6);
      int a = int.parse(result) + 1;
      String BillingIdpad = a.toString().padLeft(5, '0');
      // print(BillingIdpad); //get function to get billing id
      return BillingIdpad;
    }
  }

  String get Taxnumber {
    var list = List.generate(50, (index) => index + 1)
      ..shuffle(); //get function to get taxnumber
    return list.take(5).join('');
  }

  void dispose() {
    print("deleted");
    super.dispose();
  }

  void initState() {
    // productsmapsecond = [];
    // productsIDs = [];
    super.initState();
  }

  Future<void> insertData(List<Billing2> l) async {
    // await fetchProductIds();
    // await fetchProdata2();
    var url = Uri.parse(
        "http://192.168.174.1/billing_inventory_php/insertbilling2.php");
    print("items" +
        order
            .where((element) => int.parse(element["count"]!) > 0)
            .length
            .toString() +
        "sellingamount" +
        totalSellingCost.toString() +
        "purchaseamount" +
        totalPurchasePrice.toString() +
        'billindId' +
        BillingIdnew(l).toString() +
        "billingtaxnum" +
        Taxnumber);
    var response =
     await http.post(url, body: {
      "billingid": "B" +
          BillingIdnew(l)
              .toString(), //insertdata function in database refer inserbilling.php file
      "billingdatetime": DateTime.now().toString(),
      "billingtaxnum": Taxnumber,
      "items": order
          .where((element) => int.parse(element["count"]!) > 0)
          .length
          .toString(),
      "sellingamount": totalSellingCost.toString(),
      "purchaseamount": totalPurchasePrice.toString(),
      "discount": "1"
    });
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('error hahaha');
    }
  }

  void calculate(List<Map<String, String>> list) {
    double purchase = 0.0;
    double selling = 0.0;
    for (int i = 0; i < list.length; i++) {
      purchase +=
          double.parse(list[i]["costPrice"]!) * int.parse(list[i]["count"]!);
      print(purchase);
      selling += (double.parse(list[i]['sellingPrice']!) *
              int.parse(list[i]["count"]!)) -
          (double.parse(list[i]["sellingPrice"]!) *
                  int.parse(list[i]["count"]!) *
                  int.parse(list[i]['discount']!)) /
              100;
    }
    totalPurchasePrice = purchase.toInt();
    totalSellingCost = selling.toInt();
  }

  Future<void> getbillingdata() async {
    const jsonEndpoint =
        "http://192.168.174.1/billing_inventory_php/getbillingdata.php";
    final response = await http.get(Uri.parse(jsonEndpoint));
    if (response.statusCode == 200) {
      List billing = await json.decode(response.body);
      billingdata = billing
          .map((billing) => Billing2.fromMap(billing))
          .toList(); //returns whole value
      print(billingdata);
    } else {
      throw Exception('ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 0.03 * w),
        child: SingleChildScrollView(
          child: FutureBuilder<List<Billing2>>(
            future:
                downloadJSON(), //future is downloadJson which extracts the data from backend
            builder: (context, snapshot) {
              if (snapshot.hasError)
                print(snapshot.error);
              else if (snapshot.hasData) {
                curr = snapshot.data ?? []; //null safety
                return Padding(
                  padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Filter By',
                              style: TextStyle(fontSize: w * 0.05)),
                          SizedBox(
                            width: w * 0.1,
                          ),
                          dropdown(),
                        ],
                      ),
                      SalesTable(
                        list: updateList(
                            dropdownvalue), //get the updated list and pass it to Salles Table widget
                      ),
                      SizedBox(
                        height: 0.05 * h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 0.1 * w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            calcprofit(curr) > 0
                                ? Text(
                                    "Profit Percentage :" +
                                        calcprofit(curr).toStringAsFixed(
                                            2), //Calc profit and return a double which gets precised using function
                                    style: TextStyle(
                                        fontSize: 0.03 * h,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  )
                                : Text(
                                    "Loss Percentage :" +
                                        calcprofit(curr)
                                            .abs()
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 0.03 * h,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                            SizedBox(
                              height: 0.05 * h,
                            ),
                            Text(
                              "Revenue:\u{20B9}" +
                                  calcrevenue(curr).toStringAsFixed(2),
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
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () async {
            order = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomerScreen()),
            );
            print(order);
            if (order.isNotEmpty) {
              updatePro();
              await getbillingdata();
              calculate(order);
              insertData(billingdata);
            }
          }),
    );
  }
}
