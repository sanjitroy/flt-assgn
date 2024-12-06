import 'package:flutter/material.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_demensions.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/typography.dart';
import 'package:purr/design_system/widgets/responsive_sized_box.widget.dart';
import 'package:purr/design_system/widgets/rounded_edge_button.widget.dart';

class GradientContainerWithOverflowingImage extends StatelessWidget {
  final String title;
  final String buttonText;
  final String imageUrl;
  final VoidCallback onButtonPressed;
  final double heightInPercentage;
  final double widthInPercentage;
  const GradientContainerWithOverflowingImage({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.imageUrl,
    required this.onButtonPressed,
    this.heightInPercentage = 0.3,
    this.widthInPercentage = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: ResponsiveDimensions.getProportionalHeight(context, 0.28),
          margin: ResponsiveEdgeInsets.symmetric(
            context,
            vertical: 8,
            horizontal: ResponsivePadding.defaultHorizontalPadding,
          ),
          padding: ResponsiveEdgeInsets.symmetric(
            context,
            vertical: 24,
            horizontal: ResponsivePadding.defaultHorizontalPadding,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.azureBreeze,
                AppColors.lavenderMist,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: ResponsiveDimensions.getProportionalWidth(
                  context,
                  widthInPercentage / 2,
                ),
                child: Text(
                  title,
                  style: AppTypography.bodyTextBold2.copyWith(
                    color: AppColors.charcoalBlack,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ResponsiveSizedBox(
                width: 8,
              ),
              RoundedEdgeButton(
                text: buttonText,
                onTap: () {
                  print('Add to cart button pressed');
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: -10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: ResponsiveDimensions.getResponsiveHeight(context, 150),
              height: ResponsiveDimensions.getResponsiveHeight(context, 150),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.charcoalBlack.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(8, 4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
