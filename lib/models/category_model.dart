import 'package:open_cart/models/base_model.dart';

class CategoryModel extends BaseModel {
  final String categoryName;
  final String? categoryImageUrl;

  CategoryModel({required this.categoryName, required this.categoryImageUrl});

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
        categoryName: data["categoryName"],
        categoryImageUrl: data["categoryImageUrl"]);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "categoryName": categoryName,
        "categoryImageUrl": categoryImageUrl,
      };
}
