import 'package:flutter/material.dart';
import '../app_colors.dart';

class ConstructorTextStyle {
  static const TextStyle typeName = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle title = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 22.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static TextStyle cost = const TextStyle(
    fontFamily: 'Koulen',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors.redColor,
  );

  static const TextStyle inputText = TextStyle(
      fontFamily: 'Koulen',
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      color: Colors.white);
  static const TextStyle more = TextStyle(
      fontFamily: 'Koulen',
      fontSize: 13.0,
      fontWeight: FontWeight.w300,
      color: Colors.white);
  static const TextStyle date = TextStyle(
      fontFamily: 'Koulen',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppColors.blueColor);

  static const TextStyle lable = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
  static TextStyle snackBar = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.blueColor,
  );
}
