import 'package:flutter/material.dart';
import 'package:open_cart/providers/address_provider.dart';
import 'package:open_cart/screens/add_address_screen.dart';
import 'package:open_cart/utils/colors.dart';

class AddNewAdressScreenBottomNavBarWidget extends StatelessWidget {
  const AddNewAdressScreenBottomNavBarWidget({
    Key? key,
    required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              await AddressProvider().fetchAddressDetails();
              Navigator.of(context).pushReplacementNamed(AddressScreen.route);
            },
            child: Container(
              child: const Center(
                child: Text('Go back'),
              ),
              width: deviceSize.width / 2,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2, color: colorDarkGrey)),
            ),
          ),
          Container(
            height: 50,
            width: deviceSize.width / 2,
            child: const Center(child: Text('Pay')),
            decoration: BoxDecoration(
                color: colorOrangeCustom,
                border: Border.all(width: 0.2, color: colorDarkGrey)),
          )
        ],
      ),
    );
  }
}
