import 'package:flutter/material.dart';
import 'package:open_cart/utils/styles.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    required this.header,
    Key? key,
  }) : super(key: key);
  final String header;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        header,
        style: tsCorangeCustomFFPrimaryS45,
      ),
    );
  }
}
