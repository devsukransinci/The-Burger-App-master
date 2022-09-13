import 'package:flutter/material.dart';
import 'package:open_cart/providers/order_provider.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/custom_appbar_1_widget.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  static const String route = 'my_orders';
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  late OrderProvider _orderProvider;
  @override
  void initState() {
    _orderProvider = OrderProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: _orderProvider)],
        builder: (context, _) {
          return Scaffold(
            appBar: const CustomAppBar1Widget(title: 'My Orders'),
            body: Consumer<OrderProvider>(builder: (context, provider, _) {
              return ListView.builder(
                  itemCount: provider.orders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Image.network(provider
                                          .orders[index]
                                          .products[0]["productImage"]),
                                    ),
                                    SBW30(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            '${provider.orders[index].products[0]["productName"]}',
                                            style:
                                                tsCOrangeCustomFFPrimaryS25,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            'Ordered at ${DateTime.parse(provider.orders[index].orderedAt).toString()}',
                                            style: tsCGrey500WBold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SBH10(),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Payment Mode',
                                          style: tsCDarkGreyWBold,
                                        ),
                                        Text(provider
                                            .orders[index].paymentMode),
                                        SBH20(),
                                        Text(
                                          'Total Amount',
                                          style: tsCDarkGreyWBold,
                                        ),
                                        Text(provider
                                            .orders[index].totalAmount
                                            .toString()),
                                      ],
                                    ),
                                    SBW30(),
                                    SizedBox(
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Shipping Address',
                                                style: tsAppBarTitle,
                                              ),
                                              Text(provider.orders[index]
                                                  .addressLine1),
                                              Text(provider.orders[index]
                                                  .addressLine2),
                                              Text(provider
                                                  .orders[index].city),
                                              Text(provider
                                                  .orders[index].pincode),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                        // ListTile(
                        //   tileColor: colorFF,
                        // title: Text(
                        //     'Ordered at ${DateTime.parse(provider.orderDetails[index].orderedAt).toString()}'),
                        // subtitle: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'Shipping Address',
                        //       style: tsCDarkGreyWBold,
                        //     ),
                        //     Text(provider.orderDetails[index].addressLine1),
                        //     Text(provider.orderDetails[index].addressLine2),
                        //     Text(provider.orderDetails[index].city),
                        //     Text(provider.orderDetails[index].pincode),
                        //   ],
                        // ),
                        //   trailing: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         'Payment Mode',
                        //         style: tsCDarkGreyWBold,
                        //       ),
                        //       Text(provider.orderDetails[index].paymentMode),
                        //       SBH20(),
                        //       Text(
                        //         'Total Amount',
                        //         style: tsCDarkGreyWBold,
                        //       ),
                        //       Text(provider.orderDetails[index].totalAmount
                        //           .toString()),
                        //     ],
                        //   ),
                        // ),
                        );
                  });
            }),
          );
        });
  }

  _initAsync() async {
    await _orderProvider.fetchOrders();
  }
}
