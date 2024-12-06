import 'package:flutter/material.dart';
import 'package:purr/design_system/responsiveness/responsive_demensions.dart';

class ResponsiveFonts {
  static double getFontSize(BuildContext context, double proportion) {
    double baseFontSize = 16.0;
    double screenWidth = ResponsiveDimensions.getScreenWidth(context);

    if (screenWidth > 600) {
      return baseFontSize * proportion * 1.2;
    }

    return baseFontSize * proportion;
  }
}
