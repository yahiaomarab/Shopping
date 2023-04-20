import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

 const defaultColor=Colors.purple;
 final backGround= HexColor('F0FFFF');
 const textColor=Colors.black;


//*Important*: this is Custom Color for Primary Swatch:
const MaterialColor customColor = MaterialColor(
 customColorValue,
 <int, Color>{
  50: Color(0xFF13CA87),
  100: Color(0xFF13CA87),
  200: Color(0xFF13CA87),
  300: Color(0xFF13CA87),
  400: Color(0xFF13CA87),
  500: Color(customColorValue),
  600: Color(0xFF13CA87),
  700: Color(0xFF13CA87),
  800: Color(0xFF13CA87),
  900: Color(0xFF13CA87),
 },
);

const int customColorValue = 0xFF13CA87;