import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:open_cart/screens/login_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: TextLiquidFill(
            text: 'BS',
            waveColor: colorOrangeCustom,
            boxBackgroundColor: colorDarkGrey,
            textStyle: tsCorangeS200Wbold
            // boxHeight: 300.0,
        ),
      ),
    ),
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(
        //       'BS',
        //       style: tsCOrangeCustomFFPrimaryS100,
        //       textAlign: TextAlign.center,
        //     ),
        //     Center(
        //       child: SizedBox(
        //         width: 100,
        //         child: LinearProgressIndicator(
        //           color: colorOrangeCustom,
        //           backgroundColor: colorDarkGrey,
        //         ),
        //       ),
        //     ),
        //     SBH20(),
        //     SizedBox(
        //       height: 60,
        //       child: Row(
        //         mainAxisSize: MainAxisSize.max,
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: <Widget>[
        //           const SizedBox(width: 20.0, height: 100.0),
        //           // const Text(
        //           //   'Be',
        //           //   style: TextStyle(fontSize: 43.0),
        //           // ),
        //           const SizedBox(width: 20.0, height: 100.0),
        //           DefaultTextStyle(
        //             style: const TextStyle(
        //               fontSize: 40.0,
        //               fontFamily: primaryFont,
        //             ),
        //             child: AnimatedTextKit(animatedTexts: [
        //               RotateAnimatedText('FRESH'),
        //               RotateAnimatedText('DELICIOUS'),
        //               RotateAnimatedText('DIFFERENT'),
        //             ]),
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        );
  }

  void _initAsync() async {
    await Future.delayed(const Duration(seconds: 6));
    await Navigator.of(context).pushReplacementNamed(LoginScreen.route);
  }
}
