
class Billing {
  final String billingId;
  final String billingDateTime;
  final int billingTaxNum;
 // final int discount;
  final int items;
  final int billingamount;
  final int sellingamount;

  Billing({
    required this.billingId,
    required this.billingDateTime,
    required this.billingTaxNum,
    required this.billingamount,
    required this.items,
   // required this.discount,
    required this.sellingamount
  });

  factory Billing.fromJson(Map<dynamic, dynamic> jsonData) {
    return Billing(
      billingId: jsonData['BillingID'],
      billingDateTime: jsonData['BillingDateTime'],
      billingTaxNum: int.parse(jsonData['BillingTaxNum']),
      items:int.parse( jsonData['Items']),
      billingamount:  int.parse(jsonData['BillingAmount']),
     // discount: int.parse(jsonData['discount']),
      sellingamount:int.parse( jsonData['SellingAmount'])
    );
  }
}
