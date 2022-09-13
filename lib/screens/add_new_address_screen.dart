// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:open_cart/providers/address_provider.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/add_new_address_screen_bottom_navbar_widget.dart';
import 'package:open_cart/widgets/text_form_field_widget_with_label.dart';
import 'package:provider/provider.dart';

class AddNewAddressScreen extends StatefulWidget {
  static const String route = '/add_new_address_screen';
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController addressline1Controller = TextEditingController();
  final TextEditingController addressline2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  late AddressProvider _addressProvider;
  @override
  void initState() {
    _addressProvider = AddressProvider();
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: _addressProvider)],
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar:
                AddNewAdressScreenBottomNavBarWidget(deviceSize: deviceSize),
            appBar: AppBar(
              title: const Text('Adding your delivery address'),
            ),
            body: const AddAdressFormBodyWidget(),
          );
        });
  }

  void _initAsync() async {
    await _addressProvider.fetchAddressDetails();
  }
}


class AddAdressFormBodyWidget extends StatelessWidget {
  const AddAdressFormBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressline1Controller =
        TextEditingController();
    final TextEditingController addressline2Controller =
        TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController pincodeController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SBH10(),
            Text(
              'Add a new Address',
              style: tsCBlackFFPrimaryS25,
            ),
            const SBH15(),
            Column(
              children: [
                TextFormFieldWithLabelWidget(
                  label: 'Address Line 1',
                  controller: addressline1Controller,
                ),
                TextFormFieldWithLabelWidget(
                  label: 'Address Line 2',
                  controller: addressline2Controller,
                ),
                TextFormFieldWithLabelWidget(
                  label: 'City',
                  controller: cityController,
                ),
                TextFormFieldWithLabelWidget(
                  label: 'Pincode',
                  controller: pincodeController,
                ),
                ElevatedButton(
                    onPressed: () {
                      final String addressLine1 = addressline1Controller.text;
                      final String addressLine2 = addressline2Controller.text;
                      final String city = cityController.text;
                      final String pincode = pincodeController.text;
                      AddressProvider().addAddressDetails(
                          addressLine1: addressLine1,
                          addressLine2: addressLine2,
                          city: city,
                          pincode: pincode);
                      // Navigator.of(context)
                      //     .pushReplacementNamed(AddressScreen.route);
                      addressline1Controller.clear();
                      addressline2Controller.clear();
                      cityController.clear();
                      pincodeController.clear();
                    },
                    child: const Text('submit'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
