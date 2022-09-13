import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.validator,
    required this.label,
    required this.obscure,
    required this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final Function validator;
  final bool obscure;
  final String label;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscure,
      style: tsCwhiteFFPrimaryS15,
      controller: controller,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        fillColor: colorGrey700,
        filled: true,
        labelStyle: tsCwhiteFFPrimaryS15,
        border: OutlineInputBorder(borderRadius: bRC30),
        label: Text(label),
      ),
    );
  }
}
