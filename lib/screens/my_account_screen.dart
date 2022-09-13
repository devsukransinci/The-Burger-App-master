import 'package:flutter/material.dart';
import 'package:open_cart/providers/auth_provider.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatefulWidget {
  static const String route = '/myAccount';
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const _MyAccountScreenAppBarWidget(),
      body: SingleChildScrollView(
        child: Consumer<AuthorizationProvider>(builder: (context, provider, _) {
          return Container(
            height: deviceSize.height,
            width: deviceSize.width,
            color: colorDarkGrey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SBH20(),
                  Center(
                      child: _MyAccountScreenImageWidget(deviceSize: deviceSize)),
                  const SBH30(),
                  Text(
                    'Basic Details',
                    style: tsCOrangeCustomFFPrimaryS15,
                  ),
                  const SBH20(),
                  _MyAccountScreenTextBoxWidget(
                    label: 'User name',
                    text: provider.user.userName.toString(),
                  ),
                  _MyAccountScreenTextBoxWidget(
                    label: 'User ID',
                    text: provider.user.userId.toString(),
                  ),
                  _MyAccountScreenTextBoxWidget(
                    label: 'Email ID',
                    text: provider.user.userEmail.toString(),
                  ),
                  _MyAccountScreenTextBoxWidget(
                    label: 'Phone Number',
                    text: provider.user.userPhone.toString(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

}
class _MyAccountScreenImageWidget extends StatelessWidget {
  const _MyAccountScreenImageWidget({
    Key? key,
    required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: bRC100,
          image: const DecorationImage(
            image: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/opencart-shop-94f38.appspot.com/o/people_images%2FdummyDP.png?alt=media&token=6e2d6d6f-e956-432e-a020-d657a058a4bf',
            ),
            fit: BoxFit.cover,
          )),
    );
  }
}
class _MyAccountScreenTextBoxWidget extends StatelessWidget {
  final String text;
  final String label;
  const _MyAccountScreenTextBoxWidget({Key? key, required this.text, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tsCOrangeCustomFFPrimaryS10,
        ),
        const SBH5(),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 50,
          child: Text(
            text,
            style: tsCwhiteFFPrimaryS15,
          ),
          decoration: BoxDecoration(
              borderRadius: bRC20,
              border: Border.all(width: 1, color: colorFF)),
        ),
        const SBH20(),
      ],
    );
  }
}
class _MyAccountScreenAppBarWidget extends StatelessWidget
    with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const _MyAccountScreenAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        'My Account',
        style: tsCOrangeCustomFFPrimaryS20,
      ),
    );
  }
}