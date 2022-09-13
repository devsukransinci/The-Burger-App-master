import 'package:flutter/material.dart';
import 'package:open_cart/screens/home_page_screen.dart';
import 'package:open_cart/utils/colors.dart';

class OrderPlacedScreen extends StatefulWidget {
  static const String route = '/order_placed_screen';
  const OrderPlacedScreen({Key? key}) : super(key: key);

  @override
  _OrderPlacedScreenState createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  void initState() {
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFF,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image.network(
            //     'https://cdn.dribbble.com/users/1711715/screenshots/5389025/day_5.png'),
            Image.asset('assets/images/burger_images/order_placed_burger.png'),
            const Text('Order Successfully Placed!')
          ],
        ),
      ),
    );
  }

  _initAsync() async {
    await Future.delayed(const Duration(seconds: 5));
    await Navigator.of(context).pushReplacementNamed(HomeScreen.route);
  }
}
