import 'package:open_cart/models/base_model.dart';

class CartTotalModel extends BaseModel {
  final String? userId;
  final double? totalPrice;

  CartTotalModel({this.userId, this.totalPrice});

  factory CartTotalModel.fromMap(Map<String, dynamic> data) => CartTotalModel(
      userId: data["userId"],
      totalPrice: double.parse(data["totalAmount"].toString()));

  Map<String, dynamic> toMap() => <String, dynamic>{
        "userId": userId,
        "totalAmount": totalPrice,
      };
}
