import 'dart:ui';

import 'package:flutter/material.dart';

ColTheme coltheme = ColTheme();

class ColTheme {
  Color primarycolor = const Color(0xFF3350a0);
  Color background = const Color(0xFF97b5fe);
  Color foreground = const Color(0xFF041853);
  Color floatbutton = const Color(0xFFed0bfd);

  TextStyle fontweightw400 = const TextStyle(
      color: Colors.white,
      fontFamily: 'Noto',
      fontSize: 30.0,
      fontWeight: FontWeight.w400);

  TextStyle fontweightw100 = const TextStyle(
      color: Colors.white,
      fontFamily: 'Noto',
      fontWeight: FontWeight.w100);

  TextStyle fontweightw300 = const TextStyle(
      color: Color(0xFF97b5fe),
      fontFamily: 'Noto',
      fontSize: 16.0,
      fontWeight: FontWeight.w300);

  TextStyle fontweightw200 = const TextStyle(
      color: Colors.white,
      fontFamily: 'Noto',
      fontSize: 20.0,
      fontWeight: FontWeight.w200);

  TextStyle splashscreenfont = const TextStyle(
      color: Colors.white,
      fontFamily: 'Noto',
      fontSize: 15.0,
      fontWeight: FontWeight.w200);

}
