import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_cart/providers/address_provider.dart';
import 'package:open_cart/providers/auth_provider.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/providers/order_provider.dart';
import 'package:open_cart/providers/payments_model_provider.dart';
import 'package:open_cart/screens/home_page_screen.dart';
import 'package:open_cart/screens/splash_screen.dart';
import 'package:open_cart/test_screen.dart';
// import 'package:open_cart/screens/home_page_screen.dart';
// import 'package:open_cart/screens/splash_screen.dart';
import 'package:open_cart/utils/routes.dart';
import 'package:open_cart/utils/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthorizationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentModelsModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        )
      ],
      builder: (context, child) {
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: mainAppTheme,
            routes: routes,
            // initialRoute: TestScreen.route,
            initialRoute: SplashScreen.route,
          );
        }
      },
    );
  }
}
