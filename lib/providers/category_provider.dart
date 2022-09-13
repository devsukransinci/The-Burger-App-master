// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_cart/models/category_model.dart';
import 'package:open_cart/providers/_mixins.dart';
import 'package:open_cart/providers/base_provider.dart';

class CategoryProvider extends BaseProvider with MixinProgressProvider {
  List<CategoryModel> _categoryList = <CategoryModel>[];

  List<CategoryModel> get categoryList => _categoryList;

  set categoryList(List<CategoryModel> val) {
    _categoryList = val;
    notifyListeners();
  }

  Future<CategoryModel?> fetchProducts() async {
    isLoading = true;
    try {
      final data =
          await FirebaseFirestore.instance.collection("categories1").get();
      _categoryList =
          data.docs.map((doc) => CategoryModel.fromMap(doc.data())).toList();
    } catch (ex) {
      print(ex.toString());
    } finally {
      isLoading = false;
    }
  }
}
