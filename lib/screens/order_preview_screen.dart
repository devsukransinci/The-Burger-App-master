// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:open_cart/providers/cart_provider.dart';
import 'package:open_cart/providers/order_provider.dart';
import 'package:open_cart/screens/payment_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/bottom_navbar_doule_button_widget.dart';
import 'package:open_cart/widgets/icon_with_label_widget.dart';
import 'package:provider/provider.dart';

class OrderPreviewScreen extends StatefulWidget {
  static const String route = '/order_preview_screen';
  const OrderPreviewScreen({Key? key}) : super(key: key);

  @override
  State<OrderPreviewScreen> createState() => _OrderPreviewScreenState();
}

class _OrderPreviewScreenState extends State<OrderPreviewScreen> {
  late CartProvider _cartProvider;
  late OrderProvider _orderProvider;
  @override
  void initState() {
    _cartProvider = CartProvider();
    _orderProvider = OrderProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _orderProvider),
          ChangeNotifierProvider.value(value: _cartProvider),
        ],
        builder: (context, _) {
          return Scaffold(
              appBar: const _OrderPageAppBarWidget(),
              bottomNavigationBar: const _OrderPageBottomNavbarWidget(),
              body: SingleChildScrollView(
                child: Column(
                  children: const [
                    SBH10(),
                    _OrderSummaryPageProgressTabWidget(),
                    SBH20(),
                    _CartListWidget(),
                    SBH5(),
                    _ShippingAddressWidget(),
                  ],
                ),
              ));
        });
  }

  _initAsync() async {
    await _orderProvider.fetchOrderDetails();
    await _cartProvider.fetchProducts();
  }
}

class _OrderPageAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const _OrderPageAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: colorTransparent,
      title: const Text('Order Details'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OrderPageBottomNavbarWidget extends StatelessWidget {
  const _OrderPageBottomNavbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavbarDoubleButtonWidget(
      deviceSize: MediaQuery.of(context).size,
      leftText: 'Go back',
      onTapLeft: () {
        Navigator.of(context).pop();
      },
      onTapRight: () {
        Navigator.of(context).pushNamed(PaymentScreen.route);
      },
      rightText: 'Continue',
    );
  }
}

class _OrderSummaryPageProgressTabWidget extends StatelessWidget {
  const _OrderSummaryPageProgressTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const IconWithLabelWidget(
                iconData: Icons.check_circle,
                label: 'Address',
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: colorFF,
                ),
              ),
              const IconWithLabelWidget(
                iconData: Icons.filter_2,
                label: 'Order Summary',
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: colorFF,
                ),
              ),
              const IconWithLabelWidget(
                iconData: Icons.filter_3,
                label: 'Payment',
              ),
            ],
          ),
        ));
  }
}

class _ShippingAddressWidget extends StatelessWidget {
  const _ShippingAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SBH20(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Shipping Address',
              style: tsAppBarTitle,
            ),
          ),
          Consumer<OrderProvider>(
            builder: (context, provider, _) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: provider.orderDetails.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(provider.orderDetails.first.addressLine1
                              .toString()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(provider.orderDetails.first.addressLine2
                                  .toString()),
                              Text(
                                provider.orderDetails.first.city.toString(),
                              ),
                              Text(
                                provider.orderDetails.first.pincode.toString(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ));
            },
          ),
          const SBH10(),
        ],
      ),
    );
  }
}

class _CartListWidget extends StatelessWidget {
  const _CartListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, _) {
      return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.builder(
              itemCount: provider.cartList.length,
              itemBuilder: (context, index) {
                final value = provider.cartList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: colorFF,
                    leading: Image.network(value.productImage.toString()),
                    title: Text(value.productName!),
                    subtitle: Text(value.productPrice.toString()),
                    trailing: Text(value.productQuantity.toString()),
                  ),
                );
              }));
    });
  }
}
