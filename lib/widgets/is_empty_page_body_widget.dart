import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/styles.dart';

class IsEmptyPageBodyWidget extends StatelessWidget {
  final String text;
  const IsEmptyPageBodyWidget({
    Key? key,
    required this.text,
    required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorDarkGrey,
      height: deviceSize.height,
      width: deviceSize.width,
      child: Center(
        child: Text(
          text,
          style: tsCwhiteFFPrimaryS15,
        ),
      ),
    );
  }
}