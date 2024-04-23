import 'dart:ui';

final class FontConstants {
  static const String fontFamily = "Georama";
}

final class FontWeightManger {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

final class FontSize {
  static const double s0 = 0.0;
  static const double s5 = 5.0;
  static const double s6 = 6.0;
  static const double s7 = 7.0;
  static const double s8 = 8.0;
  static const double s9 = 9.0;
  static const double s10 = 10.0;
  static const double s11 = 11.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s15 = 15.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s24 = 24.0;
  static const double s26 = 26.0;
  static const double s28 = 28.0;
  static const double s30 = 30.0;
  static const double s42 = 42.0;
}

final class LineHeight {
  static const double h0 = 0;
  static const double h9_38 = 9.38;
  static const double h10 = 10.0;
  static const double h10_55 = 10.55;
  static const double h11_72 = 11.72;
  static const double h12 = 12.0;
  static const double h14 = 14.0;
  static const double h14_6 = 14.6;
  static const double h16 = 16.0;
  static const double h16_5 = 16.5;
  static const double h18 = 18.0;
  static const double h18_75 = 18.75;
  static const double h19 = 19.0;
  static const double h20 = 20.0;
  static const double h20_59 = 20.59;
  static const double h21 = 21;
  static const double h22 = 22.0;
  static const double h23_8 = 23.8;
  static const double h23_44 = 23.44;
  static const double h24 = 24.0;
  static const double h26 = 26.0;
  static const double h27_2 = 27.2;
  static const double h28 = 28.0;
  static const double h30 = 30.0;
  static const double h34 = 34.0;
  static const double h36 = 36.0;
  static const double h42 = 42.0;
  static const double h48 = 48.0;
}

final class FontHeight {
  static double calFontHeight(
      {required double? fontSize, required double? lineHeight}) {
    if ([fontSize, lineHeight].contains(null)) return 1.0;
    return lineHeight! / fontSize!;
  }
}

/// 18 Medium * 18/22
TextStyle? get style500S18H222 {
  return TextStyle(
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: FontHeight.calFontHeight(fontSize: 18, lineHeight: 22),
  );
}

const kGray202020 = Color(0xFF4D4D4F);
const kGray202020Opacity90 = Color(0xE6202020);
const kRedButtonColor = Color(0xFFE31837);
const kGreyBorderColor = Color(0xFFEDEDED);
const focusedBorderColor = Color.fromARGB(255, 219, 218, 218);
const fillColor = Color.fromRGBO(243, 246, 249, 0);
const redfontColor = Color(0xFFC01630);
