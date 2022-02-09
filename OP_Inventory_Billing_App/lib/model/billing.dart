// To parse this JSON data, do
//
//     final billings = billingsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

// List<Billings> billingsFromJson(String str) => List<Billings>.from(json.decode(str).map((x) => Billings.fromJson(x)));

// String billingsToJson(List<Billings> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//Billing Second model
class Billing2{
  Billing2({
    required this.billingId,
    required this.billingDateTime,
    required this.billingTaxNum,
    required this.items,
    required this.sellingAmount,
    required this.purchaseAmount,
    this.discount,
  });

  final String billingId;
  final String  billingDateTime;
  final int  billingTaxNum;
  final int  items;
  final int  sellingAmount;
  final int  purchaseAmount;
  int ? discount;

  factory Billing2.fromMap(Map<String, dynamic> jsonData) => Billing2(
    billingId: jsonData["BillingID"].toString(),
    billingDateTime: jsonData["BillingDateTime"],
    billingTaxNum: int.parse(jsonData["BillingTaxNum"]),
    items: int.parse(jsonData["Items"]),
    sellingAmount: int.parse(jsonData["SellingAmount"]),
    purchaseAmount: int.parse(jsonData["PurchaseAmount"]),
    discount: int.parse(jsonData["Discount"]),
  );

  Map<String, dynamic> toJson() => {
    "BillingID": billingId == null ? null : billingId,
    "BillingDateTime": billingDateTime == null ? null : billingDateTime,
    "BillingTaxNum": billingTaxNum == null ? null : billingTaxNum,
    "Items": items == null ? null : items,
    "SellingAmount": sellingAmount == null ? null : sellingAmount,
    "PurchaseAmount": purchaseAmount == null ? null : purchaseAmount,
    "Discount": discount == null ? null : discount,
  };
}
