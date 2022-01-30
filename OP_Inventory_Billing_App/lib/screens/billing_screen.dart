import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:op_inventory_billing_app/model/products/product.dart';
import '../widgets/billing_card.dart';
import '../widgets/payement_card.dart';

List productsmap = [];
List productsmapsecond = [];
List productsIDs = [];
List productsQuantity = [];

Future<void> fetchProductIds() async {
  var url = Uri.parse(
      "http://192.168.0.7/products_php_files/fetchbillingid.php");
  final response = await get(url);
  if (response.statusCode == 200) {
    List productsIds = json.decode(response.body);
    print(productsIds);
    for(int i = 0;i < productsIds.length;i++){
      if(productsIDs.contains(productsIds[i]['product_id'])){
      }else{
        productsIDs.add(productsIds[i]['product_id']);
        productsQuantity.add(productsIds[i]['quantity']);
        print(productsIDs);
      }
    }
  } else {
    throw Exception('No data found.');
  }
}


Future<List<Product>> fetchProdata2() async {
  var url = Uri.parse("http://192.168.0.7/products_php_files/fetchselectedproducts.php");
  for(int i = 0;i < productsIDs.length;i++){
    var response = await http.post(url, body: {
      "productId": productsIDs[i].toString(),                          
    });
    if(response.statusCode == 200){
      productsmapsecond.add(json.decode(response.body));
      // if(response.body.isEmpty) {
      //   fetchProdata();
      //   json.decode(response.body);
      // }
      print(productsmapsecond);
      print(productsmapsecond.length);
    }
    else{
      throw Exception('We were not able to successfully download the json data.');
    }
  }
  return productsmapsecond.map((product)  => Product.fromJson(product[0])).toList();
}

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);
  @override
  _BillingState createState() => _BillingState();
}

//
//This function's purpose was to increment a value by checking last value from database

double totalPurchasePrice = 0;
double totalSellingCost = 0;
String time = DateTime.now().toString();


class _BillingState extends State<BillingScreen> {
  void calculate(List<Product> list) {
    double purchase = 0.0;
    double selling = 0.0;
    for (int i = 0; i < list.length; i++) {
      purchase += double.parse(list[i].productCost);
      selling += (double.parse(list[i].sellingPrice) - (double.parse(list[i].sellingPrice) * int.parse(list[i].discount!)/100));
    }
    totalPurchasePrice = purchase;
    totalSellingCost = selling;
  }
  void dispose() {
    List productsQuantity = [];
    productsmapsecond = [];
    productsIDs = [];
    productsmap = [];
    print("deleted");
    super.dispose();
  }

  void initState(){
    productsmapsecond = [];
    fetchProductIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
          future: fetchProdata2(),
        builder: (context, snapshot) {
          List<dynamic> billinglist = snapshot.data ?? [];
          List<Product> productid = snapshot.data ?? [];
          calculate(productid);
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 560,
                    width: double.infinity,
                    child: ListView.builder(
                            itemCount: billinglist.length, itemBuilder:(BuildContext context, int index) {
                              //sellingPrice
                              return BillingCard(cost: double.parse(billinglist[index].sellingPrice), time: time, discount: int.parse(billinglist[index].discount), itemName: billinglist[index].productName, items: productsQuantity[index],);
                        }),
                  ),
                ),
             PayementCard(time:time,items:productid.length, sellingPrice: totalSellingCost, purchasePrice: totalPurchasePrice, discount: 1,),
              ],
            ),
          );
        }
      ),
    );
  }
}
