import 'package:flutter/material.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/providers/favourites_provider.dart';
import 'package:open_cart/providers/food_items_provider.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/widgets/addto_buttons_widget.dart';
import 'package:open_cart/widgets/custom_appbar_widget.dart';
import 'package:open_cart/widgets/custom_product_details_body_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String route = '/product_detail_screen';
  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late FoodProvider _foodProvider;
  late CartProvider _cartProvider;

  @override
  void initState() {
    _foodProvider = FoodProvider();
    _cartProvider = CartProvider();

    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  void dispose() {
    _foodProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var map = ModalRoute.of(context)!.settings.arguments as Map;
    final deviceSize = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FoodProvider>.value(value: _foodProvider),
          ChangeNotifierProvider(create: (context) => FavouritesProvider()),
          ChangeNotifierProvider.value(value: _cartProvider),
        ],
        builder: (context, child) {
          return Consumer<FoodProvider>(builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Scaffold(
                bottomNavigationBar:
                    AddToButtonsWidget(deviceSize: deviceSize, map: map),
                body: SingleChildScrollView(
                  child: Container(
                    color: colorDarkGrey,
                    width: deviceSize.width,
                    child: Column(
                      children: [
                        Consumer<CartProvider>(builder: (context, provider, _) {
                          return const CustomAppBarWidget();
                        }),
                        CustomProductDetailsBodyWidget(
                          deviceSize: deviceSize,
                          map: map,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          });
        });
  }

  void _initAsync() async {
    await _foodProvider.fetchProducts();
    await _cartProvider.fetchProducts();
  }
}
