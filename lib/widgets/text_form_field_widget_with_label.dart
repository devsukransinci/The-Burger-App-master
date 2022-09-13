import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';

class TextFormFieldWithLabelWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const TextFormFieldWithLabelWidget({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tsCOrangeCustomFFPrimaryS15,
        ),
        const SBH15(),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: colorFF,
            filled: true,
            border:
                OutlineInputBorder(borderSide: BorderSide(color: colorGrey400)),
            hintText: 'Enter your $label',
          ),
        ),
        const SBH15(),
      ],
    );
  }
}
