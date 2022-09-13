import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/styles.dart';

class DrawerTileCustomWidget extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final Function? onPressed;
  const DrawerTileCustomWidget({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed!();
      },
      child: ListTile(
        leading: Icon(
          iconData,
          color: colorFF,
        ),
        title: Text(
          title.toString(),
          style: tsCwhiteFFPrimaryS15,
        ),
      ),
    );
  }
}
