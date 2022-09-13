import 'package:flutter/material.dart';
import 'package:open_cart/utils/form_validators.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/widgets/auth_page_custom_text_form_field_widget.dart';
import 'package:open_cart/widgets/auth_page_login_button_widget.dart';

class LoginFormWidget extends StatelessWidget {
  LoginFormWidget({
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWidget(
              keyboardType: TextInputType.emailAddress,
              obscure: false,
              controller: emailController,
              validator: validateEmail,
              label: 'Enter your Email Id'),
          const SBH20(),
          TextFormFieldWidget(
              keyboardType: TextInputType.visiblePassword,
              obscure: true,
              controller: passwordController,
              validator: validatePassword,
              label: 'Enter your password'),
          const SBH30(),
          LoginButtonWidget(
            emailController: emailController,
            passwordController: passwordController,
            formKey: _formKey,
          ),
        ],
      ),
    );
  }
}
