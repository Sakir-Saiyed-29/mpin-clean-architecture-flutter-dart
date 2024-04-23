import 'package:flutter/material.dart';
import 'package:mpin_demo/core/utils/extensions.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFF2EBF1),
  100: Color(0xFFDFCEDD),
  200: Color(0xFFC9ADC7),
  300: Color(0xFFB38CB0),
  400: Color(0xFFA3749F),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF8B5386),
  700: Color(0xFF80497B),
  800: Color(0xFF764071),
  900: Color(0xFF642F5F),
});
const int _primaryPrimaryValue = 0xFF935B8E;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFAFF7),
  200: Color(_primaryAccentValue),
  400: Color(0xFFFF49EE),
  700: Color(0xFFFF30EB),
});
const int _primaryAccentValue = 0xFFFF7CF2;
var colorGrey = "#F0F0F0".toColor();
var colorWhite = "#FFFFFF".toColor();
var colorLightPink = "#935B8E".toColor();
var colorAppTextGrey = "#707372".toColor();
var colorAppTextBlack = "#2C2928".toColor();
var radioFillColor = "#8E8E8E".toColor();
var colorDaryGrey = "#5A5A5A".toColor();
