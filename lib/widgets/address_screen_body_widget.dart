// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:open_cart/providers/address_provider.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/widgets/icon_with_label_widget.dart';
import 'package:provider/provider.dart';

class AddressScreenBody extends StatefulWidget {
  static const String route = '/address_screen_body';
  const AddressScreenBody({Key? key}) : super(key: key);

  @override
  State<AddressScreenBody> createState() => _AddressScreenBodyState();
}

class _AddressScreenBodyState extends State<AddressScreenBody> {
  late AddressProvider _addressProvider;
  late var isSelected;

  @override
  void initState() {
    _addressProvider = AddressProvider();
    Future.microtask(() => _initAsync());
    isSelected = _addressProvider.addressList.first;
    super.initState();
  }

  // @override
  // void dispose() {
  //   _addressProvider.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Consumer<AddressProvider>(
      builder: (context, provider, _) {
        return
            // MultiProvider(
            //     providers: [ChangeNotifierProvider.value(value: _addressProvider)],
            //     builder: (context, _) {
            //       return
            Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _AddressPageProgressTabWidget(
                deviceSize: deviceSize,
              ),
              const SBH20(),
              SizedBox(
                height: deviceSize.height,
                child: ListView.builder(
                  itemCount: provider.addressList.length,
                  itemBuilder: (context, index) {
                    // final Map map = provider.addressList[index].toMap();
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: bRC20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<AddressProvider>(
                          builder: (context, provider, _) {
                            return ListTile(
                              tileColor: colorTransparent,
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await provider.deleteAddress(index);
                                },
                              ),
                              leading: Radio(
                                  value: provider.addressList[index],
                                  groupValue: isSelected,
                                  onChanged: (s) {
                                    isSelected = s;
                                    print('s is : $s');
                                    setState(() {});
                                  }),
                              title: Text(
                                provider.addressList[index].addressLine1
                                    .toString(),
                                style: const TextStyle(fontSize: 15),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.addressList[index].addressLine2
                                        .toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    provider.addressList[index].city.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    provider.addressList[index].pincode
                                        .toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _initAsync() async {
    _addressProvider.fetchAddressDetails();
  }
}

class _AddressPageProgressTabWidget extends StatelessWidget {
  const _AddressPageProgressTabWidget({
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
