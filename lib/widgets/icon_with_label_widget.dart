import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/styles.dart';


class IconWithLabelWidget extends StatelessWidget {
  final String label;
  final IconData iconData;
  const IconWithLabelWidget({
    Key? key,
    required this.label,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconData,
          color: colorFF,
        ),
        Text(
          label,
          style: tsCwhiteFFPrimaryS12,
        )
      ],
    );
  }
}