import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/widgets/half_width_bottom_navbar_widget.dart';


class BottomNavbarDoubleButtonWidget extends StatelessWidget {
  final String leftText;
  final String rightText;
  final Function onTapLeft;
  final Function onTapRight;
  const BottomNavbarDoubleButtonWidget({
    Key? key,
    required this.deviceSize,
    required this.leftText,
    required this.rightText,
    required this.onTapLeft,
    required this.onTapRight,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: colorOrangeCustom,
      child: Row(
        children: [
          HalfWidthBottomNavbarButtonWidget(
            deviceSize: deviceSize,
            color: colorFF,
            onPressed: onTapLeft,
            text: leftText,
          ),
          HalfWidthBottomNavbarButtonWidget(
            deviceSize: deviceSize,
            color: colorOrangeCustom,
            onPressed: onTapRight,
            text: rightText,
          ),
        ],
      ),
    );
  }
}