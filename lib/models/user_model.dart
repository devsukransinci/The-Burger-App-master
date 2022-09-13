import 'package:open_cart/models/base_model.dart';

class UserModel extends BaseModel {
  final String? userId;
  final String? userEmail;
  final String? userName;
  final String? userPhone;

  UserModel(
      { this.userName,
       this.userPhone,
       this.userId,
       this.userEmail});

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
      userId: data["userId"],
      userEmail: data["email"],
      userName: data["name"],
      userPhone: data["phone"]);

  Map<String, dynamic> toMap() => <String, dynamic>{
        "userId": userId,
        "email": userEmail,
        "name": userName,
        "phone": userPhone,
      };
}
