import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';


class IsVegBadgeWidget extends StatelessWidget {
  const IsVegBadgeWidget({
    Key? key,
    required this.map,
  }) : super(key: key);

  final Map map;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: map["isVeg"] ? Colors.green : colorRed, width: 1)),
      width: 20,
      height: 20,
      child: Center(
        child: Icon(Icons.circle,
            size: 15, color: map["isVeg"] ? Colors.green : colorRed),
      ),
    );
  }
}


