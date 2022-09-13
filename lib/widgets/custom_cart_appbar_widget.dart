import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';

class CustomCartAppBarWidget extends StatelessWidget {
  const CustomCartAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(' My Cart'),
      backgroundColor: colorFF,
      toolbarHeight: 50,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
