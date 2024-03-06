import 'package:flutter/material.dart';

class AppColors {
  //static Color lightAccent = Color.fromRGBO(173, 223, 255, 1);
  static Color primary = Colors.blue;
  //static Color darkAccent = Color.fromRGBO(9, 12, 155, 1);

  static void updatePrimaryColor(Color newColor) {
    primary = newColor;
  }
}