import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:purr/design_system/responsiveness/responsive_demensions.dart';

class ResponsivePadding {
  static const double defaultHorizontalPadding = 16.0;
  static const double defaultVerticalPadding = 16.0;
  static EdgeInsets getPadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {
      return EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0);
    }

    return EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  }
}

class ResponsiveEdgeInsets {
  static EdgeInsets all(BuildContext context, double value) {
    return EdgeInsets.all(
        ResponsiveDimensions.getProportionalWidth(context, value));
  }

  static EdgeInsets fromLTRB(BuildContext context, double left, double top,
      double right, double bottom) {
    return EdgeInsets.fromLTRB(
      ResponsiveDimensions.getResponsiveWidth(context, left),
      ResponsiveDimensions.getResponsiveHeight(context, top),
      ResponsiveDimensions.getResponsiveWidth(context, right),
      ResponsiveDimensions.getResponsiveHeight(context, bottom),
    );
  }

  static EdgeInsets symmetric(BuildContext context,
      {double vertical = 0, double horizontal = 0}) {
    return EdgeInsets.symmetric(
      vertical: (vertical > 0)
          ? ResponsiveDimensions.getResponsiveHeight(context, vertical)
          : 0,
      horizontal: (horizontal > 0)
          ? ResponsiveDimensions.getResponsiveWidth(context, horizontal)
          : 0,
    );
  }

  static EdgeInsets only(BuildContext context,
      {double top = 0, double bottom = 0, double left = 0, double right = 0}) {
    return EdgeInsets.only(
      top: ResponsiveDimensions.getProportionalHeight(context, top),
      bottom: ResponsiveDimensions.getProportionalHeight(context, bottom),
      left: ResponsiveDimensions.getProportionalWidth(context, left),
      right: ResponsiveDimensions.getProportionalWidth(context, right),
    );
  }
}
