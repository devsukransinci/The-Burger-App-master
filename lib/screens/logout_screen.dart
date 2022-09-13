import 'package:flutter/material.dart';
import 'package:open_cart/screens/login_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/sized_box_custom.dart';

class LogoutScreen extends StatefulWidget {
  static const String route = '/logout';
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDarkGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SBH20(),
            Text(
              'Logging out...',
              style: TextStyle(color: colorFF),
            )
          ],
        ),
      ),
    );
  }

  void _initAsync() async {
    await Future.delayed(const Duration(seconds: 2));
    await Navigator.of(context).pushReplacementNamed(LoginScreen.route);
  }
}
