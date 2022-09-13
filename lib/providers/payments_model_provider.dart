// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_cart/models/cart_total_model.dart';
import 'package:open_cart/models/payment_modes_model.dart';
import 'package:open_cart/providers/_mixins.dart';
import 'package:open_cart/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentModelsModelProvider extends BaseProvider
    with MixinProgressProvider {
  List<PaymentModesModel> _paymentModes = <PaymentModesModel>[];

  List<PaymentModesModel> get paymentModes => _paymentModes;

  List<CartTotalModel> _cartTotal = <CartTotalModel>[];

  List<CartTotalModel> get cartTotal => _cartTotal;

  set paymentModes(List<PaymentModesModel> val) {
    _paymentModes = val;
    notifyListeners();
  }

  double totalAmount = 0;

  Future<PaymentModesModel?> fetchPayments() async {
    isLoading = true;
    print('step1 - payments');
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    print('step2 - payments : $userId');

    try {
      print('step3 - payments');
      await FirebaseFirestore.instance
          .collection("paymentModes")
          .get()
          .then((value) async {
        print('step4 - payments');
        _paymentModes = value.docs
            .map(
              (doc) => PaymentModesModel.fromMap(
                doc.data(),
              ),
            )
            .toList();
        print('step5 - payments : ${_paymentModes.length}');
      }).catchError((err) => print(err));
    } catch (ex) {
      print(ex.toString());
    } finally {
      print('step6 - payments');

      isLoading = false;
    }
  }

  Future<CartTotalModel?> fetchPriceDetails() async {
    isLoading = true;

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      await FirebaseFirestore.instance
          .collection("cartTotal")
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) async {
        _cartTotal = value.docs
            .map(
              (doc) => CartTotalModel.fromMap(
                doc.data(),
              ),
            )
            .toList();
      }).catchError((err) => print(err));
    } catch (ex) {
      print(ex.toString());
    } finally {
      isLoading = false;
    }
  }
}
