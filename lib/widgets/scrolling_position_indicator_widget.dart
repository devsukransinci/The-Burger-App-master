import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/sized_box_custom.dart';

class ScrollingPositionIndiacatorWidget extends StatelessWidget {
  const ScrollingPositionIndiacatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(color: colorFF, borderRadius: bRC50),
            width: 80,
            height: 3,
          ),
        ),
        const SBH5(),
        Center(
          child: Container(
            decoration:
                BoxDecoration(color: Colors.white30, borderRadius: bRC50),
            width: 70,
            height: 2,
          ),
        ),
      ],
    );
  }
}
