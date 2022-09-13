import 'package:flutter/material.dart';
import 'package:open_cart/providers/favourites_provider.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:provider/provider.dart';
import 'package:open_cart/utils/extensions.dart';

class FavouritesScreen extends StatefulWidget {
  static const String route = 'cart_screen';
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late FavouritesProvider _provider;
  final double totalAmount = 0.0;
  @override
  void initState() {
    _provider = FavouritesProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FavouritesProvider>.value(
            value: _provider,
          ),
        ],
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Wishlist'),
            ),
            body: _FavouritesScreenBodyWidget(deviceSize: deviceSize),
          ).withProviderProgress<FavouritesProvider>();
        });
  }

  void _initAsync() async {
    await _provider.fetchProducts();
  }
}

class _FavouritesScreenBodyWidget extends StatelessWidget {
  const _FavouritesScreenBodyWidget({
    Key? key,
    required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: colorDarkGrey,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: deviceSize.height,
              child:
                  Consumer<FavouritesProvider>(builder: (context, provider, _) {
                return ListView.builder(
                    itemCount: provider.favouritesList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.black45,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: _FavouritesScreenTileWidget(index: index),
                        ),
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavouritesScreenTileWidget extends StatelessWidget {
  const _FavouritesScreenTileWidget({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(builder: (context, provider, _) {
      return ListTile(
        tileColor: Colors.transparent,
        leading: Image.network(
            provider.favouritesList[index].productImage.toString(),
            fit: BoxFit.cover),
        title: Text(
          provider.favouritesList[index].productName.toString(),
          style: tsCOrangeCustomFFPrimaryS20,
        ),
        subtitle: Text(
          provider.favouritesList[index].productPrice.toString(),
          style: tsCFFS20W500,
        ),
        trailing: IconButton(
          onPressed: () => provider.removeFromWishlist(
              index: index,
              productPrice: provider.favouritesList[index].productPrice),
          icon: Icon(
            Icons.delete,
            color: colorFF,
          ),
        ),
      );
    });
  }
}
