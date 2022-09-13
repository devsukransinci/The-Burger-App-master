// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_cart/models/popular_deals_model.dart';
import 'package:open_cart/providers/_mixins.dart';
import 'package:open_cart/providers/base_provider.dart';

class PopularDealsProvider extends BaseProvider with MixinProgressProvider {
  List<PopularDealsModel> _categoryList = <PopularDealsModel>[];

  List<PopularDealsModel> get categoryList => _categoryList;

  set categoryList(List<PopularDealsModel> val) {
    _categoryList = val;
    notifyListeners();
  }

  Future<PopularDealsModel?> fetchProducts() async {
    isLoading = true;
    try {
      final data =
          await FirebaseFirestore.instance.collection("popularDeals").get();
      await Future.delayed(const Duration(seconds: 2));
      _categoryList =
          data.docs.map((doc) => PopularDealsModel.fromMap(doc.data())).toList();
      // print('value : ${data.docs.length}');
    } catch (ex) {
      print(ex.toString());
    } finally {
      isLoading = false;
    }
  }
}
