// ignore_for_file: unused_local_variable, avoid_print, invalid_return_type_for_catch_error, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_cart/models/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressProvider with ChangeNotifier {
  List<AddressModel> _addressList = <AddressModel>[];

  List<AddressModel> get addressList => _addressList;

  set addressList(List<AddressModel> val) {
    _addressList = val;
    notifyListeners();
  }

  static final AddressProvider _instance = AddressProvider.initialise();

  AddressProvider.initialise()
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

  factory AddressProvider() => _instance;
  final Dio _dio;

  Future<void> addAddressDetails({
    required addressLine1,
    required addressLine2,
    required city,
    required pincode,
  }) async {
    final address = FirebaseFirestore.instance.collection("addresses");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    return address.add({
      'userId': userId,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'pincode': pincode,
    }).then((value) {});
  }

  /// Function to delete an address from list.
  Future<void> deleteAddress(index) async {
    final cart = await FirebaseFirestore.instance.collection("addresses").get();
    String docId = (cart.docs.elementAt(index).id);
    return FirebaseFirestore.instance
        .collection("addresses")
        .doc(docId)
        .delete();
  }

  Future<AddressModel?> fetchAddressDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    print(userId);

    try {
      await FirebaseFirestore.instance
          .collection("addresses")
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) async {
        _addressList =
            value.docs.map((doc) => AddressModel.fromMap(doc.data())).toList();
        print(addressList.length);
      }).catchError((err) => print(err));
    } catch (ex) {
      print(ex.toString());
    } finally {}
  }

  Future<void> selectAddress({required map}) async {
    final val = FirebaseFirestore.instance.collection("test");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final userVal = await FirebaseFirestore.instance
        .collection("addresses")
        .where('userId', isEqualTo: userId)
        .get();
    final String _id = userVal.docs.first.id;
    return val.doc(_id).set({
      'userId': userId,
      'addressLine1': map["addressLine1"],
      'addressLine2': map["addressLine2"],
      'city': map["city"],
      'pincode': map["pincode"],
    }).then((value) {
      print('sucessful');
    });
  }
}
