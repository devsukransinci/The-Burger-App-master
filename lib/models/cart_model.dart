class CartModel {
  final String? cartId;
  final String? userId;
  final double? productPrice;
  final String? productName;
  final String? productImage;
  final int? productQuantity;

  CartModel({
    this.productName,
    this.cartId,
    this.userId,
    this.productPrice,
    this.productImage,
    this.productQuantity,
  }) : super();

  factory CartModel.fromMap(Map<String, dynamic> data) {
    return CartModel(
      cartId: data["cartId"],
      userId: data["userId"],
      productPrice: data["productPrice"],
      productName: data["productName"],
      productImage: data["productImage"],
      productQuantity: data["productQuantity"],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "cartId": cartId,
        "userId": userId,
        "productPrice": productPrice,
        "productName": productName,
        "productImage": productImage,
        "productQuantity": productQuantity,
      };
}
