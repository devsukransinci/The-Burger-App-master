// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:open_cart/providers/auth_provider.dart';
import 'package:open_cart/screens/login_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/dialog_boxes.dart';
import 'package:open_cart/utils/form_validators.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/widgets/auth_page_header_widget.dart';
import 'package:open_cart/widgets/signup_text_button_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = '/RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return _ThisInheritedWidget(
      emailController: _emailController,
      nameController: _nameController,
      passwordController: _passwordController,
      phoneController: _phoneController,
      child: Scaffold(
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
                  header: 'Register',
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          style: tsCwhiteFFPrimaryS15,
                          controller: _nameController,
                          validator: (value) => validateName(value),
                          decoration: InputDecoration(
                            fillColor: colorGrey700,
                            filled: true,
                            labelStyle: tsCwhiteFFPrimaryS15,
                            border: OutlineInputBorder(borderRadius: bRC30),
                            label: const Text('Name'),
                          ),
                        ),
                        const SBH20(),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          style: tsCwhiteFFPrimaryS15,
                          controller: _emailController,
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
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          style: tsCwhiteFFPrimaryS15,
                          controller: _phoneController,
                          validator: (value) => validatePhone(value),
                          decoration: InputDecoration(
                            fillColor: colorGrey700,
                            filled: true,
                            labelStyle: tsCwhiteFFPrimaryS15,
                            border: OutlineInputBorder(borderRadius: bRC30),
                            label: const Text('Phone'),
                          ),
                        ),
                        const SBH20(),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: tsCwhiteFFPrimaryS15,
                          controller: _passwordController,
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
                        _ThisRegisterButtonWidget(
                            passwordController: _passwordController,
                            nameController: _nameController,
                            phoneController: _phoneController,
                            formKey: _formKey)
                      ],
                    ),
                  ),
                ),
                const SignuporinTextButtonWidget(
                  authMethod: 'Login',
                  text1: 'Already have an account?',
                  route: LoginScreen.route,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ThisInheritedWidget extends InheritedWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const _ThisInheritedWidget(
      {required this.passwordController,
      required this.nameController,
      required this.phoneController,
      required this.emailController,
      required Widget child,
      Key? key})
      : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant _ThisInheritedWidget oldWidget) {
    return (oldWidget.emailController != emailController);
  }

  static _ThisInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ThisInheritedWidget>()!;
}

class _ThisRegisterButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _ThisRegisterButtonWidget({
    Key? key,
    required this.passwordController,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
  }) : super(key: key);

  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: colorOrangeCustom,
          fixedSize: const Size(150, 50),
          shape: RoundedRectangleBorder(borderRadius: bRC30)),
      onPressed: () => _onRegister(context: context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'SignUp',
            style: tsCwhiteFFPrimaryS20,
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  void _onRegister({required BuildContext context}) async {
    final String email = _ThisInheritedWidget.of(context).emailController.text;
    final String password =
        _ThisInheritedWidget.of(context).passwordController.text;
    final String name = _ThisInheritedWidget.of(context).nameController.text;
    final String phone = _ThisInheritedWidget.of(context).phoneController.text;

    try {
      if (formKey.currentState!.validate()) {
        final provider = context.read<AuthorizationProvider>();
        await provider.signup(email, password).then((value) async =>
            await provider.addUserDetails(
                email: email, name: name, password: password, phone: phone));
        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
        showRegisterSucessDialog(context: context);
      }
    } catch (error) {
      print(
          'try4################################################################################################');
      print('This is the error : ${error.toString()}');
      var errMessage = 'Unable to SignUp at the moment 😢';
      if (error.toString().contains("INVALID_PASSWORD")) {
        errMessage = 'Invalid Password!';
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errMessage = 'Invalid Email!';
      } else if (error.toString().contains("USER_DISABLED")) {
        errMessage = 'Your Account has been disabled!';
      }
      print(
          'try5################################################################################################');
      showErrorRegisterDialog(context: context, message: errMessage);
    }
    print(
        'try6################################################################################################');
  }
}
