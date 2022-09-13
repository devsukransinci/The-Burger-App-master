import 'package:flutter/material.dart';
import 'package:open_cart/screens/register_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/form_validators.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/auth_page_header_widget.dart';
import 'package:open_cart/widgets/auth_page_login_button_widget.dart';
import 'package:open_cart/widgets/signup_text_button_widget.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var isObscure = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: colorDarkGrey,
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(
                header: 'Login',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // WHEN EXTRACTED AS A SEPERATE WIDGET, FIELD ENTRIES ARE DISSAPEARING ON UNFOCUSING.
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        style: tsCwhiteFFPrimaryS15,
                        controller: emailController,
                        validator: (value) => validateEmail(value),
                        decoration: InputDecoration(
                          fillColor: colorGrey700,
                          filled: true,
                          labelStyle: tsCwhiteFFPrimaryS15,
                          border: OutlineInputBorder(borderRadius: bRC30),
                          label: const Text('Email'),
                        ),
                      ),
                      const SBH20(),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isObscure,
                        style: tsCwhiteFFPrimaryS15,
                        controller: passwordController,
                        validator: (value) => validatePassword(value),
                        decoration: InputDecoration(
                          fillColor: colorGrey700,
                          filled: true,
                          labelStyle: tsCwhiteFFPrimaryS15,
                          border: OutlineInputBorder(borderRadius: bRC30),
                          label: const Text('Password'),
                        ),
                      ),
                      const SBH30(),
                      //LOGIN BUTTON WIDGET HOLDS ALL THE FUNCTIONS AND THE LOGIN LOGIC.
                      LoginButtonWidget(
                          emailController: emailController,
                          passwordController: passwordController,
                          formKey: _formKey)
                    ],
                  ),
                ),
              ),
              // CUSTOM WIDGET FOR SWITCHING BETWEEN SIGNUP OR SIGNIN
              const SignuporinTextButtonWidget(
                authMethod: 'Sign up',
                text1: 'Don\'t have an account?',
                route: RegisterScreen.route,
              )
            ],
          ),
        ),
      ),
    );
  }
}
