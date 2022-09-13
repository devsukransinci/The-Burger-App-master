import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/form_validators.dart';
import 'package:open_cart/utils/styles.dart';

class EmailTextFormFieldWidget extends StatelessWidget {
  const EmailTextFormFieldWidget({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: tsCwhiteFFPrimaryS15,
      controller: emailController,
      validator: (value) => validateEmail(value),
      decoration: InputDecoration(
        fillColor: colorGrey700,
        filled: true,
        labelStyle: tsCwhiteFFPrimaryS15,
        border: OutlineInputBorder(borderRadius: bRC30),
        label: const Text('Email Id'),
      ),
    );
  }

  
}
