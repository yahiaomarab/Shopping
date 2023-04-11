import 'package:flutter/material.dart';

import '../../colors/colors.dart';

ThemeData darkTheme = ThemeData(
    fontFamily: 'Myfont',
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: defaultColor),
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: defaultColor),
      titleTextStyle: TextStyle(
          fontFamily: 'Myfont',
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold),
      backgroundColor: Colors.black87,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.white,
        elevation: 20,
        backgroundColor: Colors.black),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontFamily: 'Myfont',
          fontSize: 20,
          height: 1.3,
          fontWeight: FontWeight.w800,
          color: Colors.white),
      bodyText2: TextStyle(
          fontFamily: 'Myfont',
          fontSize: 15,
          height: 1.3,
          fontWeight: FontWeight.w400,
          color: Colors.white),
      caption: TextStyle(
        fontFamily: 'Myfont',
        fontSize: 10,
        height: 1.3,
        fontWeight: FontWeight.w100,
        color: Colors.white70,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      focusColor: defaultColor,
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: defaultColor)),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      // border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.purple),
      ),
    ),
    iconTheme: const IconThemeData(
      color: defaultColor,
    ));
