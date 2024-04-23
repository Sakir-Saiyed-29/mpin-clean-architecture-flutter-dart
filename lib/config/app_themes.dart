import 'package:flutter/material.dart';
import 'package:mpin_demo/core/font_manager.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontConstants.fontFamily,
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.grey),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: kGray202020,
        height: FontHeight.calFontHeight(fontSize: 14, lineHeight: 16.5),
      ));
}
