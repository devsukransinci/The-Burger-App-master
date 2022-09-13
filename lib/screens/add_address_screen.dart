// // ignore_for_file: prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:open_cart/providers/address_provider.dart';
// import 'package:open_cart/screens/add_new_address_screen.dart';
// import 'package:open_cart/screens/order_preview_screen.dart';
// import 'package:open_cart/utils/colors.dart';
// import 'package:open_cart/widgets/address_screen_body_widget.dart';
// import 'package:open_cart/widgets/bottom_navbar_doule_button_widget.dart';
// import 'package:provider/provider.dart';

// class AddressScreen extends StatefulWidget {
//   static const String route = '/address_screen';
//   const AddressScreen({Key? key}) : super(key: key);

//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   late AddressProvider _addressProvider;
//   @override
//   void initState() {
//     _addressProvider = AddressProvider();
//     Future.microtask(() => _initAsync());
//     super.initState();
//   }

//   // @override
//   // void dispose() {
//   //   _addressProvider.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider.value(
//             value: _addressProvider,
//           ),
//         ],
//         builder: (context, child) {
//           return Consumer<AddressProvider>(builder: (context, provider, _) {
//             return provider.addressList.isEmpty
//                 ? const AddNewAddressScreen()
//                 : Scaffold(
// bottomNavigationBar: BottomNavbarDoubleButtonWidget(
//   deviceSize: MediaQuery.of(context).size,
//   leftText: 'Go back',
//   onTapLeft: () {
//     Navigator.of(context).pop();
//   },
//   onTapRight: () {
//     Navigator.of(context)
//         .pushNamed(OrderPreviewScreen.route);
//   },
//   rightText: 'Continue',
// ),
//                     appBar: AppBar(
//                       shadowColor: colorTransparent,
//                       title: const Text('Adding your delivery address'),
//                     ),
//                     body: const SingleChildScrollView(
//                         child: AddressScreenBody()));
//           });
//         });
//   }

//   void _initAsync() async {
//     await _addressProvider.fetchAddressDetails();
//   }
// }

// ignore_for_file: avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:open_cart/models/address_model.dart';
import 'package:open_cart/providers/address_provider.dart';
import 'package:open_cart/providers/order_provider.dart';
import 'package:open_cart/screens/order_preview_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/bottom_navbar_doule_button_widget.dart';
import 'package:open_cart/widgets/icon_with_label_widget.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String route = "/address_screen";

  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressProvider _addressProvider;
  AddressModel _value = AddressModel();
  @override
  void initState() {
    _addressProvider = AddressProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // AddressModel _value = AddressModel();
    return Scaffold(
      // backgroundColor: colorFF,
      appBar: AppBar(
        title: const Text('Add an Address'),
        shadowColor: colorTransparent,
      ),
      bottomNavigationBar: BottomNavbarDoubleButtonWidget(
        deviceSize: MediaQuery.of(context).size,
        leftText: 'Go back',
        onTapLeft: () {
          Navigator.of(context).pop();
        },
        onTapRight: () async {
          await OrderProvider().fetchOrderDetails();
          Navigator.of(context).pushNamed(OrderPreviewScreen.route);
        },
        rightText: 'Continue',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SBH10(),
            _AddAddressPageProgressTabWidget(
              deviceSize: MediaQuery.of(context).size,
            ),
            const SBH20(),
            Consumer2<AddressProvider, OrderProvider>(
                builder: (context, _addressProvider, _thisProvider, _) {
              return SizedBox(
                height: 400,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: _addressProvider.addressList.length,
                  itemBuilder: (context, index) {
                    print(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: colorFF,
                        shape: RoundedRectangleBorder(borderRadius: bRC30),
                        leading: Radio<AddressModel>(
                            value: _addressProvider.addressList[index],
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                _thisProvider.addAddressValue(
                                    map: _value.toMap());
                              });
                            }),
                        title: Text(
                          _addressProvider.addressList[index].addressLine1!,
                          style: tsCDarkGreyWBold,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _addressProvider.addressList[index].addressLine1!,
                            ),
                            Text(_addressProvider.addressList[index].city!),
                            Text(_addressProvider.addressList[index].pincode!),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            const SBH20(),
            // Consumer2<PaymentModelsModelProvider, _ThisProvider>(
            //     builder: (context, _paymentsProvider, _thisProvider, _) {
            //   return SizedBox(
            //     height: 300,
            //     width: double.infinity,
            //     child: ListView.builder(
            //       itemCount: _paymentsProvider.paymentModes.length,
            //       itemBuilder: (context, index) {
            //         print('paymentIndex:$index');
            //         return Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: ListTile(
            //               tileColor: colorFF,
            //               shape:
            //                   RoundedRectangleBorder(borderRadius: bRC20),
            //               leading: Radio<PaymentModesModel>(
            //                   value:
            //                       _paymentsProvider.paymentModes[index],
            //                   groupValue: _paymentMode,
            //                   onChanged: (value) {
            //                     setState(() {
            //                       _paymentMode = value!;
            //                       _thisProvider.addPaymentValue(
            //                           map: _paymentMode.toMap());
            //                     });
            //                   }),
            //               title: Text(_paymentsProvider
            //                   .paymentModes[index].paymentMode!),
            //               trailing: FaIcon(IconData(int.parse(
            //                   _paymentsProvider
            //                       .paymentModes[index].paymentIcon
            //                       .toString())))),
            //         );
            //       },
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
    // });
  }

  _initAsync() async {
    await _addressProvider.fetchAddressDetails();
    _value = context.read<AddressProvider>().addressList[0];
  }
}

class _AddAddressPageProgressTabWidget extends StatelessWidget {
  const _AddAddressPageProgressTabWidget({
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
                iconData: Icons.filter_1,
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
