import 'package:flutter/material.dart';
import 'package:open_cart/providers/address_provider.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/widgets/cart_list_section_widget.dart';
import 'package:open_cart/widgets/cart_screen_bottom_section_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String route = 'cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

double counter = 0;

class _CartScreenState extends State<CartScreen> {
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CartProvider>.value(
            value: _provider,
          ),
        ],
        builder: (context, child) {
          return Scaffold(
            bottomNavigationBar: const CartScreenBottomSectionWidget(),
            appBar: AppBar(
              title: const Text('My Cart'),
            ),
            body: const CartListSectionWidget(),
          );
        });
  }

  void _initAsync() async {
    await _provider.fetchProducts();
    await _provider.fetchTotalAmount();
    await _addressProvider.fetchAddressDetails();
  }
}
