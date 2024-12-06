// lib/design_system/typography.dart

import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle headline1 = TextStyle(
      fontFamily: 'SFProDisplay', fontSize: 32, fontWeight: FontWeight.bold);
  static TextStyle headline2 = TextStyle(
      fontFamily: 'SFProDisplay', fontSize: 24, fontWeight: FontWeight.w600);
  static TextStyle headline3 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle bodyText = TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyTextBold = TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle labelText = TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodyTextBold2 = TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1,
  );
}
