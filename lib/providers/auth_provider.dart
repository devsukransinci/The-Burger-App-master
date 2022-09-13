// ignore_for_file: unused_local_variable, avoid_print, invalid_return_type_for_catch_error, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_cart/models/auth_user_model.dart';
import 'package:open_cart/models/user_model.dart';
import 'package:open_cart/utils/exceptions.dart';
import 'package:open_cart/utils/urls.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? _expiryDate;
  UserModel _user = UserModel();

  UserModel get user => _user;

  set user(UserModel val) {
    _user = val;
    notifyListeners();
  }

  static final AuthorizationProvider _instance =
      AuthorizationProvider.initialise();

  AuthorizationProvider.initialise()
      : _dio = Dio()
          ..interceptors.add(
            LogInterceptor(
              request: true,
              requestBody: true,
              requestHeader: true,
              responseBody: true,
              responseHeader: true,
              error: true,
            ),
          );

  factory AuthorizationProvider() => _instance;
  final Dio _dio;

  Future<AuthUserModel?> signup(String email, String password) async {
    try {
      await _dio.post(registrationUrl, data: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }).then((value) async {
        _token = value.data["idToken"];
        _userId = value.data["localId"];
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', _userId.toString());
        _expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(value.data["expiresIn"])));

        return AuthUserModel.fromJson(value.data);
      });
    } on DioError catch (e) {
      final errMessage = await e.response!.data["error"]["message"];
      return errMessage;
    }
  }

  Future<bool> addUserDetails({
    required name,
    required email,
    required phone,
    required password,
  }) async {
    final cart = FirebaseFirestore.instance.collection("users");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    return cart.add({
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) async {
      final order = FirebaseFirestore.instance.collection("test");
      // final prefs = await SharedPreferences.getInstance();
      // final userId = prefs.getString('userId');
      return order.add({
        "addressLine1": "",
        "addressLine2": "",
        "city": "",
        "paymentIcon": "",
        "paymentMode": "",
        "pincode": "",
        "products": [],
        "orderedAt": "",
        "orderId": "",
        "totalAmount": 0,
        "userId": userId,
      }).then((value) => true);
    });
  }

  // Future<UserModel?> fetchUserDetails() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getString('userId');
  //   print(userId);

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .where('userId', isEqualTo: userId)
  //         .get()
  //         .then((value) async {
  //       _user = value.docs
  //           .map(
  //             (doc) => UserModel.fromMap(
  //               doc.data(),
  //             ),
  //           )
  //           .toList()
  //           .first;
  //       print(_user.userName);
  //     }).catchError((err) => print(err));
  //   } catch (ex) {
  //     print(ex.toString());
  //   } finally {}
  // }

  Future<AuthUserModel?> signin(String email, String password) async {
    try {
      await _dio.post(loginUrl, data: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }).then((value) async {
        _token = value.data["idToken"];
        _userId = value.data["localId"];
        var val = await SharedPreferences.getInstance();
        await val.setString('userId', _userId!);
        _expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(value.data["expiresIn"])));
        notifyListeners();
        final loginData = await SharedPreferences.getInstance();
        loginData.setString('token', _token.toString());
        loginData.setString('userId', _userId.toString());
        loginData.setString('dateTime', _expiryDate!.toIso8601String());
        return AuthUserModel.fromJson(value.data);
      }).catchError((error) {
        int a = 0;

        if (error.response!.data["error"] != null) {
          final String errMessage = error.response!.data["error"]["message"];
          throw APIExceptions(msg: errMessage.toString());
        } else {
          return null;
        }
      });
    } catch (error) {
      rethrow;
    }
  }

  late bool isLogin;

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token') &&
        prefs.containsKey('userId') &&
        prefs.containsKey('dateTime')) {
      return true;
    }
    final userToken = prefs.getString('token');
    final userId = prefs.getString('userId');
    final userdateTime = prefs.getString('dateTime');
    notifyListeners();
    if (userToken != null) {
      isLogin = await prefs.setBool('isLogin', true);
      return true;
    } else {
      isLogin = await prefs.setBool('isLogin', false);
      return false;
    }
  }

  // Future<void> deleteCacheDir() async {
  //   final cacheDir = await getTemporaryDirectory();

  //   if (cacheDir.existsSync()) {
  //     cacheDir.deleteSync(recursive: true);
  //   }
  // }
  // Future<void> deleteAppDir() async {
  //   final appDir = await getApplicationSupportDirectory();

  //   if (appDir.existsSync()) {
  //     appDir.deleteSync(recursive: true);
  //   }
  // }
}
