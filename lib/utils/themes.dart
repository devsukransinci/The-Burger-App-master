import 'package:flutter/material.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/styles.dart';

final mainAppTheme = ThemeData(
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Colors.white),
    scaffoldBackgroundColor: colorDarkGrey,
    appBarTheme: AppBarTheme(backgroundColor: colorDarkGrey),
    textTheme: const TextTheme(bodyText1: TextStyle(fontFamily: primaryFont)));

final sliverAppBarIconTheme = IconThemeData(color: colorFF);
