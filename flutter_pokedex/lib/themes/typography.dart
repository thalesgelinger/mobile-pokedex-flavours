import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle get headline =>
       TextStyle(fontSize: 24, height: 32, fontWeight: FontWeight.bold);

  static TextStyle get subtitle1 =>
       TextStyle(fontSize: 14, height: 16, fontWeight: FontWeight.bold);

  static TextStyle get subtitle2 =>
       TextStyle(fontSize: 12, height: 16, fontWeight: FontWeight.bold);

  static TextStyle get subtitle3 =>
       TextStyle(fontSize: 10,  fontWeight: FontWeight.bold);

  static TextStyle get body1 =>  TextStyle(fontSize: 14, height: 16);

  static TextStyle get body2 =>  TextStyle(fontSize: 12, height: 16);

  static TextStyle get body3 =>  TextStyle(fontSize: 10, height: 16);

  static TextStyle get caption =>  TextStyle(fontSize: 8, height: 12);
}
