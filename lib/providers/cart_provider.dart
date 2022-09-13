// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_cart/models/cart_model.dart';
import 'package:open_cart/models/cart_total_model.dart';
import 'package:open_cart/providers/_mixins.dart';
import 'package:open_cart/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends BaseProvider with MixinProgressProvider {
  List<CartModel> _cartList = <CartModel>[];

  List<CartModel> get cartList => _cartList;

  set cartList(List<CartModel> val) {
    _cartList = val;
    notifyListeners();
  }

  List<CartTotalModel> _cartTotal = <CartTotalModel>[];

  List<CartTotalModel> get cartTotal => _cartTotal;

  set cartTotal(List<CartTotalModel> val) {
    _cartTotal = val;
    notifyListeners();
  }

  double totalAmount = 0;

  Future<CartModel?> fetchProducts() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      await FirebaseFirestore.instance
          .collection("cart")
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) async {
        _cartList = value.docs
            .map(
              (doc) => CartModel.fromMap(
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

  Future<CartTotalModel?> fetchTotalAmount() async {
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

  Future<void> addProductToCart({
    cartId,
    productPrice,
    required productId,
    userId,
    required productImage,
  }) async {
    final cart = FirebaseFirestore.instance.collection("cart");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    return cart.add({
      'cartId': cart.doc().id,
      'userId': userId,
      'productPrice': productPrice,
      'productName': productId,
      'productImage': productImage,
      'productQuantity': 1,
    }).then((value) {
      updateTotalAmount(productPrice: productPrice, function: '+');
      updateOrderTotalAmount(productPrice: productPrice, function: '+');
    });
  }

  /// Function to delete a product from cart.
  Future<void> deleteProduct(index, productPrice) async {
    final cart = await FirebaseFirestore.instance.collection("cart").get();
    String docId = (cart.docs.elementAt(index).id);
    updateTotalAmount(productPrice: productPrice, function: '-');
    updateOrderTotalAmount(productPrice: productPrice, function: '-');
    return FirebaseFirestore.instance.collection("cart").doc(docId).delete();
  }

  /// Updates the total amount.
//TODO: The total amount doesnt change on updating the quantity from the cart or by adding an item to cart that already exists in the cart. it only updates on adding new products or removing products.
  updateTotalAmount({productPrice, function}) async {
    final cart = FirebaseFirestore.instance.collection("cartTotal");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var cartTotal = await cart.where('userId', isEqualTo: userId).get();
    print('CartTotal is : ${cartTotal.docs.first.id}');
    var _id = cartTotal.docs.first.id;
    var total =
        await FirebaseFirestore.instance.collection("cartTotal").doc(_id).get();
    var totalAmount = total.data()!["totalAmount"];
    if (function == '+') {
      totalAmount = totalAmount + productPrice;
    } else if (function == '-') {
      totalAmount = totalAmount - productPrice;
    }
    cart.doc(_id).update({
      'totalAmount': totalAmount,
    });
  }

  updateOrderTotalAmount({productPrice, function}) async {
    final cart = FirebaseFirestore.instance.collection("test");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var cartTotal = await cart.where('userId', isEqualTo: userId).get();
    print('order total is : ${cartTotal.docs.first.id}');
    var _id = cartTotal.docs.first.id;
    var total =
        await FirebaseFirestore.instance.collection("test").doc(_id).get();
    var totalAmount = total.data()!["totalAmount"];
    if (function == '+') {
      totalAmount = totalAmount + productPrice;
    } else if (function == '-') {
      totalAmount = totalAmount - productPrice;
    }
    cart.doc(_id).update({
      'totalAmount': totalAmount,
    });
  }

  ///Function that updates the quantity of the items in cart.
  updateCartQuantity({productName, function}) async {
    final cart = FirebaseFirestore.instance.collection("cart");
    var cartList =
        await cart.where('productName', isEqualTo: productName).get();
    print('Cart is : ${cartList.docs.first.id}');
    var _id = cartList.docs.first.id;
    var list =
        await FirebaseFirestore.instance.collection("cart").doc(_id).get();
    var qty = list.data()!["productQuantity"];
    if (function == '+') {
      qty = qty + 1;
    } else if (function == '-') {
      qty = qty - 1;
    }
    cart.doc(_id).update({
      'productQuantity': qty,
    });
  }

  /// Function to check is ann element exists in the cart or not.
  Future<bool> checkIfElementExists(productName) async {
    final cart = FirebaseFirestore.instance.collection("cart");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    var cartItems = cart.where('userId', isEqualTo: userId);
    var cartList =
        await cartItems.where('productName', isEqualTo: productName).get();
    print('CartList exists and length : ${cartList.docs.length}');
    if (cartList.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
