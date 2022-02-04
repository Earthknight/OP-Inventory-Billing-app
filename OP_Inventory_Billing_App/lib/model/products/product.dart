
class Product {
  //[{"ProductID":"P100","ProductName":"Milk",
  // "ProductCost":"20","ProductinStock":"100","SellingPrice":"0","Discount":"0"}]
  final String productId;
  final String productName;
  final String productCost;
  final String productInStock;
  final String sellingPrice;
  final String? discount;
  final bool isPerishAble;
  final DateTime? expiryDate;

  Product({
    required this.productId,
    required this.productName,
    required this.productCost,
    required this.productInStock,
    required this.sellingPrice,
    this.discount,
     this.expiryDate,
    required this.isPerishAble,
  });

  factory Product.fromJson(Map<dynamic, dynamic> jsonData) {
    return Product(
      productId: jsonData['productId'],
      productName: jsonData['productName'],
      productCost: jsonData['productCost'].toString(),
      productInStock:  jsonData['productInStock'].toString(),
      sellingPrice: jsonData['sellingPrice'].toString(),
      discount: jsonData['discount'].toString(),
      expiryDate: DateTime.parse(jsonData['expiryDate']),
      isPerishAble: jsonData['isPerishAble'] == 1 ? true : false,
    );
  }
}
