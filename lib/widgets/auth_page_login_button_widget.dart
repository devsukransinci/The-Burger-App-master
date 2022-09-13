// ignore_for_file: unused_local_variable, avoid_print, void_checks

import 'package:flutter/material.dart';
import 'package:open_cart/providers/auth_provider.dart';
import 'package:open_cart/screens/home_page_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:provider/provider.dart';
import 'package:open_cart/utils/dialog_boxes.dart';

class LoginButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButtonWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: colorOrangeCustom,
          fixedSize: const Size(150, 50),
          shape: RoundedRectangleBorder(borderRadius: bRC20)),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        return _login(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Login',
            style: tsCwhiteFFPrimaryS20,
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  _login(context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      // if (formKey.currentState!.validate()) {
      await Provider.of<AuthorizationProvider>(context, listen: false)
          .signin(email, password);
      Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      showSucessDialog('Lets make your first order!', context);
      // showLoading(context);
      // }
    } catch (error) {
      print(
          'try4################################################################################################');
      print('This is the error : ${error.toString()}');
      var errMessage = 'Unable to login at the moment 😢';
      if (error.toString().contains("INVALID_PASSWORD")) {
        errMessage = 'Please enter a valid password!';
      } else if (error.toString() == "INVALID_EMAIL") {
        errMessage = 'Please enter a valid Email!';
        print(errMessage);
      } else if (error.toString().contains("USER_DISABLED")) {
        errMessage = 'Your Account has been disabled!';
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errMessage = 'The email you entered was not found 😢';
      } else {
        errMessage = 'Oops!';
      }
      print(errMessage);

      print(
          'try5################################################################################################');
      showErrorDialog(errMessage, context);
    }
    print(
        'try6################################################################################################');
    // emailController.clear();
    // passwordController.clear();
  }
}
