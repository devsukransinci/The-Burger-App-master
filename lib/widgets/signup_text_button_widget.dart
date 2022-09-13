import 'package:flutter/material.dart';
import 'package:open_cart/utils/styles.dart';

class SignuporinTextButtonWidget extends StatelessWidget {
  const SignuporinTextButtonWidget({
    required this.text1,
    required this.authMethod,
    required this.route,
    Key? key,
  }) : super(key: key);
  final String text1;
  final String authMethod;
  final String route;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: tsCwhiteFFPrimaryS15,
        ),
        TextButton(
            onPressed: () async {
              Navigator.of(context).pushReplacementNamed(route);
            },
            child: Text(
              authMethod,
              style: tsCOrangeCustomFFPrimaryS15,
            )),
      ],
    );
  }
}
