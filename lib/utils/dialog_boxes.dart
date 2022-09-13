import 'package:flutter/material.dart';
import 'package:open_cart/screens/register_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/utils/urls.dart';

void showErrorDialog(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(message),
            titleTextStyle: tsCBlackFFPrimaryS25,
            content: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Dont have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreen.route);
                      },
                      child: const Text('SignUp'),
                    ),
                  ],
                ),
                Image.network(
                  burgerAvatarUrl,
                  width: 100,
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: colorOrangeCustom,
                      shape: RoundedRectangleBorder(borderRadius: bRC10)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Retry'),
                ),
              ),
            ],
          ));
}

void showSucessDialog(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Welcome to BurgerSpot!'),
            titleTextStyle: tsCBlackFFPrimaryS25,
            content: Text(message),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: colorOrangeCustom,
                      shape: RoundedRectangleBorder(borderRadius: bRC20)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay'),
                ),
              ),
            ],
          ));
}

// void showLoading(context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         Future.delayed(const Duration(seconds: 3), () {
//           Navigator.of(context).pop();
//         });
//         return SizedBox(
//           child: Container(
//             color: colorDarkGrey,
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const CircularProgressIndicator(),
//                   const SBH10(),
//                   Text(
//                     'Just a minute!',
//                     style: tsAppBarTitle,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
// }

void showNoItemsInCartDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Items in your cart to place an order!'),
          titleTextStyle: tsCBlackFFPrimaryS25,
          content: const Text('Add something to continue'),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: colorOrangeCustom,
                    shape: RoundedRectangleBorder(borderRadius: bRC20)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
              ),
            ),
          ],
        );
      });
}

void showAddedToCart(context) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return const AlertDialog(
          title: Text('Added To Cart!'),
        );
      });
}

void alreadyInCart(context) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return const AlertDialog(
          title: Text('already in cart!'),
        );
      });
}

void showErrorRegisterDialog(
    {required String message, required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Errorrrrr!!!'),
            titleTextStyle: tsCBlackFFPrimaryS25,
            content: Text(message),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: colorOrangeCustom,
                      shape: RoundedRectangleBorder(borderRadius: bRC30)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Retry'),
                ),
              ),
            ],
          ));
}

void showRegisterSucessDialog({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Welcome to BurgerSpot!'),
            titleTextStyle: tsCBlackFFPrimaryS25,
            content: const Text('Please Login to continue'),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: colorOrangeCustom,
                      shape: RoundedRectangleBorder(borderRadius: bRC30)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay'),
                ),
              ),
            ],
          ));
}
