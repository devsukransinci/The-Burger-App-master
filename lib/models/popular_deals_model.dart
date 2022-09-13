import 'package:open_cart/models/base_model.dart';

class PopularDealsModel extends BaseModel {
  final String popularDealsName;
  final String? popularDealsImageUrl;

  PopularDealsModel({required this.popularDealsName, required this.popularDealsImageUrl});

  factory PopularDealsModel.fromMap(Map<String, dynamic> data) {
    return PopularDealsModel(
        popularDealsName: data["popularDealsName"],
        popularDealsImageUrl: data["popularDealsImageUrl"]);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "popularDealsName": popularDealsName,
        "popularDealsImageUrl": popularDealsImageUrl,
      };
}
