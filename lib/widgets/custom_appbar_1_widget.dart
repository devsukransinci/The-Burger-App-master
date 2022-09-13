import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';


class CustomAppBar1Widget extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String title;
  const CustomAppBar1Widget({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      shadowColor: colorTransparent,
    );
  }
}