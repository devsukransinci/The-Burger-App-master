class ProductModel {
  final String id;
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productImageUrl;

  ProductModel(
      {required this.id,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productImageUrl})
      : super();

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
        id: data["id"],
        productName: data["productName"],
        productDescription: data["productDescription"],
        productPrice: data["productPrice"].toString()
        ,
        productImageUrl: data["productImage"]);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "productName": productName,
        "productDescription": productDescription,
        "productPrice": productPrice,
        "productImageUrl": productImageUrl,
      };
}
