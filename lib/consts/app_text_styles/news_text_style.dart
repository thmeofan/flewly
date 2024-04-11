import 'package:flutter/material.dart';
import '../app_colors.dart';

class NewsTextStyle {
  static const TextStyle title = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static TextStyle preview = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 14.0,
    height: 18 / 12,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.5),
  );
  static const TextStyle date = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 12.0,
    height: 18 / 12,
    fontWeight: FontWeight.w500,
    color: AppColors.blueColor,
  );
  static const TextStyle read = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 12.0,
    height: 18 / 12,
    fontWeight: FontWeight.w400,
    //   color: AppColors.orangeColor,
  );
  static const TextStyle articleTitle = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 18.0,
    height: 20 / 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle articleText = TextStyle(
    fontFamily: 'Koulen',
    fontSize: 14.0,
    height: 20 / 14,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
}
