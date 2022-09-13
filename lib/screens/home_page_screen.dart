import 'package:flutter/material.dart';
import 'package:open_cart/providers/auth_provider.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/screens/favourites_screen.dart';
import 'package:open_cart/screens/my_account_screen.dart';
import 'package:open_cart/screens/products_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/widgets/custom_app_drawer_widget.dart';
import 'package:open_cart/widgets/custom_bottom_navbar_widget.dart';
import 'package:open_cart/widgets/home_screen_body.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CartProvider _cartProvider;
  late AuthorizationProvider _authProvider;
  @override
  void initState() {
    _cartProvider = CartProvider();
    _authProvider = AuthorizationProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _cartProvider),
          ChangeNotifierProvider.value(value: _authProvider)
        ],
        builder: (context, _) {
          return DefaultTabController(
            initialIndex: 0,
            length: 5,
            child: Scaffold(
              bottomNavigationBar: const MainCustomPainterBottomNavbar(),
              backgroundColor: homeScreenBgColor,
              drawer: const CustomAppDrawerWidget(),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: const TabBarView(
                  children: [
                    HomeScreenBody(),
                    BurgersScreen(),
                    FavouritesScreen(),
                    BurgersScreen(),
                    MyAccountScreen(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _initAsync() async {
    await _cartProvider.fetchProducts();
  }
}
