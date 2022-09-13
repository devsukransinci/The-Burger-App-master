import 'package:flutter/material.dart';


class HalfWidthBottomNavbarButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  const HalfWidthBottomNavbarButtonWidget({
    Key? key,
    required this.deviceSize,
    required this.text,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: deviceSize.width / 2,
        color: color,
        child: Center(child: Text(text)),
      ),
    );
  }
}