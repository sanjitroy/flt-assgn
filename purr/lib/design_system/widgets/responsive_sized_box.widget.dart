import 'package:flutter/material.dart';
import 'package:purr/design_system/responsiveness/responsive_demensions.dart';

class ResponsiveSizedBox extends StatelessWidget {
  final double width;
  final double height;
  final bool isWidthResponsive;
  final bool isHeightResponsive;

  const ResponsiveSizedBox({
    super.key,
    this.width = 0,
    this.height = 0,
    this.isWidthResponsive = true,
    this.isHeightResponsive = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width > 0)
          ? ResponsiveDimensions.getResponsiveWidth(context, width)
          : 0,
      height: (height > 0)
          ? ResponsiveDimensions.getResponsiveHeight(context, height)
          : 0,
    );
  }
}
