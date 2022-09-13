// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:open_cart/screens/cart_screen.dart';
import 'package:open_cart/utils/colors.dart';

class MainCustomPainterBottomNavbar extends StatefulWidget {
  const MainCustomPainterBottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  State<MainCustomPainterBottomNavbar> createState() => _MainCustomPainterBottomNavbarState();
}

class _MainCustomPainterBottomNavbarState extends State<MainCustomPainterBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      width: size.width,
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: _BNBCustomPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: colorOrangeCustom),
                  child: FloatingActionButton(
                      backgroundColor: colorFF,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_outline,
                            color: colorOrangeCustom,
                          ),
                          Text(
                            'Favs',
                            style: TextStyle(
                                color: colorOrangeCustom, fontSize: 10),
                          )
                        ],
                      ),
                      elevation: 0.1,
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreen.route);
                      }),
                ),
              ],
            ),
          ),
          TabBar(
              automaticIndicatorColorAdjustment: false,
              unselectedLabelColor: colorBlueGreyCustom,
              indicatorColor: Colors.transparent,
              tabs: const [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.fastfood_outlined),
                  text: 'Burgers',
                ),
                Tab(
                  child: SizedBox(
                    width: 100,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.store),
                  text: 'Orders',
                ),
                Tab(
                  icon: Icon(Icons.person),
                  text: 'Account',
                ),
              ]),
        ],
      ),
    );
  }
}

class _BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = colorOrangeCustom;

    Path path = Path();
    path.moveTo(0, 30); // Start
    path.quadraticBezierTo(0, 0, size.width * 0.3, 0);
    path.lineTo(size.width * 0.1, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.8, 0);
    path.lineTo(size.width * 0.7, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
