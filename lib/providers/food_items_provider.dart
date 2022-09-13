// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_cart/models/food_model.dart';
import 'package:open_cart/providers/_mixins.dart';
import 'package:open_cart/providers/base_provider.dart';

class FoodProvider extends BaseProvider with MixinProgressProvider {
  List<FoodModel> _foodList = <FoodModel>[];

  List<FoodModel> get foodList => _foodList;

  set foodList(List<FoodModel> val) {
    _foodList = val;
    notifyListeners();
  }

  Future<FoodModel?> fetchProducts() async {
    isLoading = true;
    try {
      final itemsData =
          await FirebaseFirestore.instance.collection("burgers").get();
      _foodList =
          itemsData.docs.map((doc) => FoodModel.fromMap(doc.data())).toList();
    } catch (ex) {
      print(ex.toString());
    } finally {
      isLoading = false;
    }
  }
}
