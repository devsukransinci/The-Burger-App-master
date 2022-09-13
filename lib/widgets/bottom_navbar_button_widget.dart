import 'package:flutter/material.dart';

class BottomNavbarButtonWidget extends StatelessWidget {
  final Function function;
  final Size deviceSize;
  final Color color;
  final String text;
  const BottomNavbarButtonWidget(
      {Key? key,
      required this.function,
      required this.deviceSize,
      required this.color,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function(),
      child: Container(
        height: 50,
        width: deviceSize.width / 2,
        color: color,
        child: Center(child: Text(text)),
      ),
    );
  }
}
