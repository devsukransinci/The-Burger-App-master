import 'package:open_cart/models/base_model.dart';

class AddressModel extends BaseModel {
  final String? userId;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? pincode;

  AddressModel(
      {this.userId,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.pincode});
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      userId: data["userId"],
      addressLine1: data["addressLine1"],
      addressLine2: data["addressLine2"],
      city: data["city"],
      pincode: data["pincode"],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "userId": userId,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "pincode": pincode,
      };
}
