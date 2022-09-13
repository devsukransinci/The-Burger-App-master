// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_cart/models/favourites_model.dart';
import 'package:open_cart/providers/_mixins.dart';
import 'package:open_cart/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesProvider extends BaseProvider with MixinProgressProvider {
  List<FavouritesModel> _favouritesList = <FavouritesModel>[];

  List<FavouritesModel> get favouritesList => _favouritesList;

  set favouritesList(List<FavouritesModel> val) {
    _favouritesList = val;
    notifyListeners();
  }

  Future<FavouritesModel?> fetchProducts() async {
    isLoading = true;

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    print('This is my userId : $userId');
    try {
      await FirebaseFirestore.instance
          .collection("favourites")
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) async {
        _favouritesList = value.docs
            .map(
              (doc) => FavouritesModel.fromMap(
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

  Future<void> addProductToFavourites(
      {favouritesId,
      productPrice,
      required productId,
      userId,
      required productImage}) async {
    final favourites = FirebaseFirestore.instance.collection("favourites");
    return favourites.add({
      'favouritesId': favourites.doc().id,
      'userId': userId,
      'productPrice': productPrice,
      'productName': productId,
      'productImage': productImage,
    }).then((value) => print('added to favourites'));
  }

  /// Function to delete a product from cart.
  Future<void> removeFromWishlist({required int index,required productPrice}) async {
    final cart = await FirebaseFirestore.instance.collection("favourites").get();
    String docId = (cart.docs.elementAt(index).id);
    return FirebaseFirestore.instance.collection("favourites").doc(docId).delete();
  }
}
