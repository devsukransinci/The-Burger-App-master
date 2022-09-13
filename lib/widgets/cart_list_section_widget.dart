// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:open_cart/providers/address_provider.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/is_empty_page_body_widget.dart';
import 'package:provider/provider.dart';

class CartListSectionWidget extends StatefulWidget {
  const CartListSectionWidget({Key? key}) : super(key: key);

  @override
  _CartListSectionWidgetState createState() => _CartListSectionWidgetState();
}

class _CartListSectionWidgetState extends State<CartListSectionWidget> {
  late CartProvider _provider;
  late AddressProvider _addressProvider;
  final double totalAmount = 0.0;
  @override
  void initState() {
    _provider = CartProvider();
    _addressProvider = AddressProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Consumer<CartProvider>(builder: (context, provider, _) {
      return provider.cartList.isEmpty
          ? IsEmptyPageBodyWidget(
              deviceSize: deviceSize,
              text: 'Your cart is empty 😢!',
            )
          : SingleChildScrollView(
              child: Container(
                color: colorDarkGrey,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: deviceSize.height * 0.8,
                      child: Consumer<CartProvider>(
                          builder: (context, provider, _) {
                        return ListView.builder(
                            itemCount: provider.cartList.length,
                            itemBuilder: (context, index) {
                              print(provider.cartList);
                              return Card(
                                color: Colors.black45,
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: CustomCartTileWidget(
                                    map: provider.cartList[index].toMap(),
                                    index: index,
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  ],
                ),
              ),
            );
    });
  }

  void _initAsync() async {
    await _provider.fetchProducts();
    await _addressProvider.fetchAddressDetails();
  }
}

class CustomCartTileWidget extends StatelessWidget {
  const CustomCartTileWidget(
      {Key? key, required this.map, required this.index})
      : super(key: key);
  // TODO: Change the map to class model object
  final Map map;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, _) {
      return ListTile(
        tileColor: Colors.transparent,
        leading:
            Image.network(map["productImage"].toString(), fit: BoxFit.cover),
        title: Text(
          map["productName"].toString(),
          style: tsCOrangeCustomFFPrimaryS20,
        ),
        subtitle: Column(
          children: [
            Text(
              map["productPrice"].toString(),
              style: tsCFFS20W500,
            ),
            const SBH10(),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: bRC20,
                color: colorOrangeCustom,
              ),
              width: 140,
              height: 30,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => _decreaseQuantity(provider),
                    child: Text(
                      '-',
                      style: TextStyle(
                        color: colorFF,
                      ),
                    ),
                  ),
                  Text(provider.cartList[index].productQuantity.toString()),
                  TextButton(
                    onPressed: () => _increaseQuantity(provider),
                    child: Text('+',
                        style: TextStyle(
                          color: colorFF,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
        trailing: IconButton(
          onPressed: () => _deleteItem(provider),
          icon: Icon(
            Icons.delete,
            color: colorFF,
          ),
        ),
      );
    });
  }

  void _decreaseQuantity(provider) async {
    await provider.updateCartQuantity(
        productName: provider.cartList[index].productName, function: '-');
    if (provider.cartList[index].productQuantity! > 1) {
      await provider.fetchProducts();
    } else {
      await provider.deleteProduct(
          index, provider.cartList[index].productPrice);
      await provider.fetchProducts();
      await provider.fetchTotalAmount();
    }
  }

  void _deleteItem(provider) async {
    await provider.deleteProduct(index, provider.cartList[index].productPrice);
    await provider.fetchProducts();
    await provider.fetchTotalAmount();
  }

  void _increaseQuantity(provider) async {
    await provider.updateCartQuantity(
        productName: provider.cartList[index].productName, function: '+');
    await provider.fetchProducts();
    await provider.fetchTotalAmount();
  }
}
