import 'package:flutter/material.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/providers/order_provider.dart';
import 'package:open_cart/screens/add_address_screen.dart';
import 'package:open_cart/screens/products_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/dialog_boxes.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:provider/provider.dart';

class CartScreenBottomSectionWidget extends StatefulWidget {
  const CartScreenBottomSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreenBottomSectionWidget> createState() =>
      _CartScreenBottomSectionWidgetState();
}

class _CartScreenBottomSectionWidgetState
    extends State<CartScreenBottomSectionWidget> {
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      height: 120,
      color: colorGrey700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Items',
                      style: tsCwhiteFFPrimaryS15,
                    ),
                    const SBH10(),
                    Text(
                      'Total Amount',
                      style: tsCwhiteFFPrimaryS15,
                    ),
                  ],
                ),
                Consumer<CartProvider>(builder: (context, provider, _) {
                  if (provider.cartTotal.isEmpty) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(provider.cartList.length.toString(),
                            style: tsCwhiteS15W300),
                        const SBH10(),
                        Text(
                            '${(provider.cartTotal[0].totalPrice)!.roundToDouble()}\$',
                            style: tsCwhiteS15W300),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                    context, BurgersScreen.route),
                child: Container(
                  height: 50,
                  width: deviceSize.width / 2,
                  color: colorFF,
                  child: const Center(
                    child: Text('Goto Burgers'),
                  ),
                ),
              ),
              Consumer<CartProvider>(builder: (context, provider, _) {
                return GestureDetector(
                  onTap: () {
                    if (provider.cartList.isEmpty) {
                      showNoItemsInCartDialog(context);
                    } else {
                      OrderProvider().updateOrderCartValue(
                          list: provider.cartList.first.toMap());
                      Navigator.of(context).pushNamed(AddressScreen.route);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: deviceSize.width / 2,
                    color: colorOrangeCustom,
                    child: const Center(
                      child: Text('Checkout'),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
