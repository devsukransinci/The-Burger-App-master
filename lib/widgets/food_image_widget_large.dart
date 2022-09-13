import 'package:flutter/material.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/urls.dart';

class FoodImageWidget extends StatelessWidget {
  const FoodImageWidget({
    Key? key,
    required this.deviceSize,
    required this.map,
  }) : super(key: key);

  final Size deviceSize;
  final Map map;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width,
      height: deviceSize.height / 2.5,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: bRC20,
          image: DecorationImage(
              image: NetworkImage(map["foodImageUrl"] ?? loadErrorImageUrl),
              fit: BoxFit.cover)),
    );
  }
}
