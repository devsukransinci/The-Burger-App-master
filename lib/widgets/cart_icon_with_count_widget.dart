import 'package:flutter/material.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:provider/provider.dart';

class CountWidget extends StatefulWidget {
  const CountWidget({Key? key}) : super(key: key);

  @override
  _CountWidgetState createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  late CartProvider _cartProvider;
  @override
  void initState() {
    _cartProvider = CartProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: _cartProvider)],
        builder: (context, _) {
          return Card(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Consumer<CartProvider>(builder: (context, provider, _) {
                  return Text(
                    provider.cartList.length.toString(),
                    style: TextStyle(color: colorFF),
                  );
                }),
              ));
        });
  }

  void _initAsync() async {
    await _cartProvider.fetchProducts();
  }
}
