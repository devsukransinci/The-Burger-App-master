// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/providers/favourites_provider.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/dialog_boxes.dart';
import 'package:open_cart/widgets/bottom_navbar_button_widget.dart';
import 'package:provider/provider.dart';

class AddToButtonsWidget extends StatelessWidget {
  const AddToButtonsWidget({
    Key? key,
    required this.deviceSize,
    required this.map,
  }) : super(key: key);

  final Size deviceSize;
  final Map map;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<FavouritesProvider>(builder: (context, provider, _) {
          return BottomNavbarButtonWidget(
              function: () => _addToWishlist(context),
              deviceSize: deviceSize,
              color: colorFF,
              text: "Add to wishlist");
        }),
        //TODO: Error in increasing quantity. Looks like error in _addOrUpdate(). look into it!
        Consumer<CartProvider>(builder: (context, provider, _) {
          return BottomNavbarButtonWidget(
              // function: () =>
              // () => _addOrUpdate(provider: provider, context: context),
              function: () => () => _addOrUpdate(provider, context),
              deviceSize: deviceSize,
              color: colorOrangeCustom,
              text: "Add to Cart");
        })
      ],
    );
  }

  ///Allows adding of an Item to the cart. Takes a context as input to pass onto the dialogbox.
  void _addToCart(context) {
    print('Added to cart');
    CartProvider().addProductToCart(
        productId: map["foodName"],
        productPrice: map["foodprice"],
        productImage: map["foodImageUrl"]);
    
    showAddedToCart(context);
  }

  ///Allows adding of an Item to the Wishlist. Takes a context as input to pass onto the dialogbox.
  void _addToWishlist(context) {
    print('Added to wishlist');
    FavouritesProvider().addProductToFavourites(
        productId: map["foodName"],
        productPrice: map["foodprice"],
        productImage: map["foodImageUrl"]);
  }

  /// A function that allows the user to check if the element already exists in the collection and ask the app to increase the quantity in the cart instead of adding another product. Takes a CartProvider and the build context as inputs.
  void _addOrUpdate(provider, context) async {
    //TODO: Changed the map item name from product name to food name. revert back incase of some error. If app runs sucessfully and as intended, remove this todo.
    if (await provider.checkIfElementExists(map["foodName"])) {
      alreadyInCart(context);
    } else {
      _addToCart(context);
    }
  }
}
