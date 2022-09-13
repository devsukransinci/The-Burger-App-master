// ignore_for_file: unused_field, avoid_print, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:open_cart/providers/auth_provider.dart';
import 'package:open_cart/screens/add_address_screen.dart';
import 'package:open_cart/screens/login_screen.dart';
import 'package:open_cart/screens/logout_screen.dart';
import 'package:open_cart/screens/my_orders_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/address_screen_body_widget.dart';
import 'package:open_cart/widgets/drawer_tile_custom_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppDrawerWidget extends StatelessWidget {
  final bool _isLoggedIn = false;
  const CustomAppDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: colorDarkGrey,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'The BurgerSpot',
                style: tsCOrangeCustomFFPrimaryS45,
              ),
            ),
          ),
          DrawerTileCustomWidget(
            title: 'Saved Addresses',
            iconData: Icons.home,
            onPressed: () {
              const AddressScreenBody();
            },
          ),
          DrawerTileCustomWidget(
            title: 'Orders',
            iconData: Icons.store,
            onPressed: () {
              Navigator.of(context).pushNamed(MyOrdersScreen.route);
            },
          ),
          DrawerTileCustomWidget(
            title: 'Deals and Offers',
            iconData: Icons.star_border,
            onPressed: () {},
          ),
          DrawerTileCustomWidget(
            title: 'Logout',
            iconData: Icons.login,
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              // prefs.remove('userId');
              // prefs.setBool('isLogin', false);
              Navigator.of(context).pushReplacementNamed(LogoutScreen.route);
            },
          ),
        ],
      ),
    ));
  }
}
