import 'package:flutter/material.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_demensions.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';

class RoundedEdgeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;
  const RoundedEdgeButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.bgColor = AppColors.charcoalBlack,
      this.textColor = Colors.white,
      thi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: ResponsiveDimensions.getResponsiveHeight(
          context,
          34,
        ),
        padding: ResponsiveEdgeInsets.symmetric(
          context,
          vertical: 4,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
