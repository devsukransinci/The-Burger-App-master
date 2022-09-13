import 'package:open_cart/models/base_model.dart';
import 'package:open_cart/models/cart_model.dart';

class OrderModel extends BaseModel {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String paymentIcon;
  final String paymentMode;
  final String pincode;
  final List<dynamic> products;
  final String orderedAt;
  final String orderId;
  final double totalAmount;
  final String userId;

  OrderModel(
      {required this.addressLine1,
      required this.addressLine2,
      required this.city,
      required this.paymentIcon,
      required this.paymentMode,
      required this.pincode,
      required this.products,
      required this.orderedAt,
      required this.orderId,
      required this.totalAmount,
      required this.userId});

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      addressLine1: data["addressLine1"],
      addressLine2: data["addressLine2"],
      city: data["city"],
      paymentIcon: data["paymentIcon"],
      paymentMode: data["paymentMode"],
      pincode: data["pincode"],
      products: data["products"],
      orderedAt: data["orderedAt"],
      orderId: data["orderId"],
      totalAmount: data["totalAmount"],
      userId: data["userId"],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "paymentIcon": paymentIcon,
        "paymentMode": paymentMode,
        "pincode": pincode,
        "products": products,
        "orderedAt": orderedAt,
        "orderId": orderId,
        "totalAmount": totalAmount,
        "userId": userId,
      };
}
