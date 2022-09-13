// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_cart/models/payment_modes_model.dart';
import 'package:open_cart/providers/order_provider.dart';
import 'package:open_cart/providers/payments_model_provider.dart';
import 'package:open_cart/screens/order_confirmed_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/bottom_navbar_doule_button_widget.dart';
import 'package:open_cart/widgets/icon_with_label_widget.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  static const String route = '/payment_screen';
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PaymentModelsModelProvider _paymentsProvider;
  late OrderProvider _orderProvider;
  PaymentModesModel _value = PaymentModesModel();

  @override
  void initState() {
    _paymentsProvider = PaymentModelsModelProvider();
    _orderProvider = OrderProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _paymentsProvider),
          ChangeNotifierProvider.value(value: _orderProvider)
        ],
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Payments'),
              shadowColor: colorTransparent,
            ),
            bottomNavigationBar: BottomNavbarDoubleButtonWidget(
              deviceSize: deviceSize,
              leftText: 'Go back',
              onTapLeft: () {
                Navigator.of(context).pop();
              },
              onTapRight: () {
                OrderProvider().addOrderId();
                OrderProvider().confirmOrder(
                    map: context.read<OrderProvider>().orderDetails.first.toMap());
                Navigator.of(context)
                    .pushReplacementNamed(OrderPlacedScreen.route);
              },
              rightText: 'Pay',
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SBH10(),
                    _PaymentsPageProgressTabWidget(deviceSize: deviceSize),
                    const SBH20(),
                    Consumer2<PaymentModelsModelProvider, OrderProvider>(
                        builder:
                            (context, _paymentModesProvider, _thisProvider, _) {
                      return SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: _paymentModesProvider.paymentModes.length,
                          itemBuilder: (context, index) {
                            print(index);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                tileColor: colorFF,
                                shape:
                                    RoundedRectangleBorder(borderRadius: bRC30),
                                leading: Radio<PaymentModesModel>(
                                    value: _paymentModesProvider
                                        .paymentModes[index],
                                    groupValue: _value,
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value!;
                                        _thisProvider.addPaymentValue(
                                            map: _value.toMap());
                                      });
                                    }),
                                title: Text(
                                  _paymentModesProvider
                                      .paymentModes[index].paymentMode!,
                                  style: tsCDarkGreyWBold,
                                ),
                                trailing: FaIcon(IconData(int.parse(
                                    _paymentModesProvider
                                        .paymentModes[index].paymentIcon
                                        .toString()))),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    const _TotalPaymentDetailsWidget()
                  ],
                ),
              ),
            ),
          );
        });
  }

  _initAsync() async {
    await _paymentsProvider.fetchPayments();
    await _orderProvider.fetchOrderDetails();
    _value = _paymentsProvider.paymentModes[0];
  }
}

class _PaymentsPageProgressTabWidget extends StatelessWidget {
  const _PaymentsPageProgressTabWidget({
    Key? key,
    required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: deviceSize.width / 1.5,
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
                iconData: Icons.check_circle,
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

class _TotalPaymentDetailsWidget extends StatefulWidget {
  const _TotalPaymentDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_TotalPaymentDetailsWidget> createState() =>
      _TotalPaymentDetailsWidgetState();
}

class _TotalPaymentDetailsWidgetState
    extends State<_TotalPaymentDetailsWidget> {
  late PaymentModelsModelProvider _paymentsProvider;

  @override
  void initState() {
    _paymentsProvider = PaymentModelsModelProvider();

    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: bRC20),
        color: colorFF,
        child: SizedBox(
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal:
                                BorderSide(width: 0.1, color: colorDarkGrey),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        height: 40,
                        child: Text(
                          'PRICE DETAILS',
                          style: TextStyle(
                              color: colorGrey500, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Consumer<OrderProvider>(builder: (context, provider, _) {
                        // print(
                        //     'totalAmount: ${provider.orderDetails.first.totalAmount.toString()}');
                        return Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          width: double.infinity,
                          height: 40,
                          child: provider.orderDetails.isEmpty
                              ? Center(
                                  child: LinearProgressIndicator(
                                    minHeight: 20,
                                    backgroundColor: colorFF,
                                    color: colorGrey400,
                                  ),
                                )
                              : SizedBox(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Price",
                                      ),
                                      Text(
                                        provider.orderDetails.first.totalAmount
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      }),
                      const _PriceDetailsWidget(
                        text1: 'Delivery charge',
                        text2: '40',
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    width: 0.1, color: colorDarkGrey))),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'AMOUNT PAYABLE',
                              style: tsCGrey500WBold,
                            ),
                            Consumer<OrderProvider>(
                              builder: (context, provider, _) {
                                if (provider.orderDetails.isEmpty) {
                                  return const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator());
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Text(
                                      //     provider.orderDetails.first.products
                                      //         .length
                                      //         .toString(),
                                      //     style: tsCwhiteS15W300),
                                      // const SBH10(),
                                      Text(
                                          '${(provider.orderDetails.first.totalAmount + 40).roundToDouble()}\$',
                                          style: tsCGrey500WBold),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ]))));
  }

  _initAsync() async {
    await _paymentsProvider.fetchPriceDetails();
  }
}

class _PriceDetailsWidget extends StatelessWidget {
  final String text1;
  final String text2;
  const _PriceDetailsWidget({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
          ),
          Text(
            text2,
          ),
        ],
      ),
    );
  }
}

class _PaymentOptionWidget extends StatefulWidget {
  final int index;
  final String text;
  final IconData icon;
  final Function function;
  const _PaymentOptionWidget({
    Key? key,
    required this.index,
    required this.text,
    required this.icon,
    required this.function,
  }) : super(key: key);

  @override
  State<_PaymentOptionWidget> createState() => _PaymentOptionWidgetState();
}

class _PaymentOptionWidgetState extends State<_PaymentOptionWidget> {
  late var isSelected;
  // late PaymentMode
  @override
  void initState() {
    isSelected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentModelsModelProvider>(
        builder: (context, provider, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          // onTap: widget.function(),
          child: ListTile(
              tileColor: colorFF,
              shape: RoundedRectangleBorder(borderRadius: bRC20),
              leading: Radio(
                  value: provider.paymentModes[widget.index],
                  groupValue: isSelected,
                  onChanged: (s) {
                    isSelected = s;
                    print('s is : $s');
                    setState(() {});
                  }),
              title: Text(widget.text),
              trailing: FaIcon(
                widget.icon,
                color: colorOrangeCustom,
              )),
        ),
      );
    });
  }
}
