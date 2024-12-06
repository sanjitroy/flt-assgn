import 'package:flutter/widgets.dart';

class ResponsiveDimensions {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getProportionalWidth(BuildContext context, double proportion) {
    return getScreenWidth(context) * (proportion );
  }

  static double getProportionalHeight(BuildContext context, double proportion) {
    return getScreenHeight(context) * (proportion );
  }

  static double getResponsiveHeight(BuildContext context, double height) {
    return getScreenHeight(context) * (height / 812);
  }

  static double getResponsiveWidth(BuildContext context, double width) {
    return getScreenWidth(context) * (width / 375);
  }
}
