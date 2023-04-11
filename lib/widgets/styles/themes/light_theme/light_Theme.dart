import 'package:flutter/material.dart';

import '../../colors/colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Myfont',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  scaffoldBackgroundColor: backGround,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: defaultColor),
    titleTextStyle: TextStyle(
        fontFamily: 'Myfont',
        color: textColor,
        fontSize: 25,
        fontWeight: FontWeight.bold),
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20),
  textTheme: TextTheme(
    bodyText1: const TextStyle(
        fontFamily: 'Myfont',
        fontSize: 20,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: Colors.black87),
    bodyText2: const TextStyle(
        fontFamily: 'Myfont',
        fontSize: 15,
        height: 1.3,
        fontWeight: FontWeight.w400,
        color: Colors.black87),
    caption: TextStyle(
      fontFamily: 'Myfont',
      fontSize: 10,
      height: 1.3,
      fontWeight: FontWeight.w100,
      color: Colors.grey[500],
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    prefixIconColor: Colors.black26,
    suffixIconColor: Colors.black26,
    focusColor: defaultColor,
    labelStyle: TextStyle(
      color: Colors.black54,
    ),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: defaultColor)),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.purple),
    ),
  ),
  iconTheme: const IconThemeData(
    color: defaultColor,
  ),
);
