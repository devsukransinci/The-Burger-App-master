import 'package:open_cart/models/base_model.dart';

class FoodModel extends BaseModel {
  final String foodName;
  final bool isVeg;
  final double foodRating;
  final int foodPrepTime;
  final String foodDetails;
  final String? foodImageUrl;
  final double? foodprice;

  FoodModel(
      {required this.isVeg,
      required this.foodRating,
      required this.foodPrepTime,
      required this.foodDetails,
      required this.foodName,
      required this.foodImageUrl,
      required this.foodprice});

  factory FoodModel.fromMap(Map<String, dynamic> data) {
    return FoodModel(
      foodName: data["foodName"],
      foodImageUrl: data["foodImageUrl"],
      foodDetails: data["foodDetails"],
      foodPrepTime: data["foodPrepTime"],
      foodRating: data["foodRating"],
      isVeg: data["isVeg"],
      foodprice: data["foodPrice"],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "foodName": foodName,
        "isVeg": isVeg,
        "foodDetails": foodDetails,
        "foodPrepTime": foodPrepTime,
        "foodRating": foodRating,
        "foodImageUrl": foodImageUrl,
        "foodprice": foodprice,
      };
}
