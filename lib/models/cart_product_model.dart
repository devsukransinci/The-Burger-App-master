import 'package:open_cart/models/base_model.dart';

class CartProductModel extends BaseModel {
  final String productId;
  final double productPrice;

  CartProductModel({required this.productId, required this.productPrice});

  factory CartProductModel.fromMap(Map<String, dynamic> data) =>
      CartProductModel(
          productId: data["productId"], productPrice: data["productPrice"]);

  Map<String, dynamic> toMap() => <String, dynamic>{
        "productId": productId,
        "productPrice": productPrice,
      };
}
