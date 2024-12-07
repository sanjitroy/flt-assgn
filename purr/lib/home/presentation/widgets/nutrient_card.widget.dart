import 'package:flutter/material.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/typography.dart';
import 'package:purr/home/core/types/menu_item.type.dart';

class NutrientCard extends StatelessWidget {
  final Nutrients nutrients;
  const NutrientCard({
    super.key,
    required this.nutrients,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveEdgeInsets.symmetric(context,
          vertical: 18.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.charcoalBlack.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NutrientContent(value: nutrients.kcal.toString(), unit: 'kcal'),
          NutrientContent(value: nutrients.grams.toString(), unit: 'grams'),
          NutrientContent(
              value: nutrients.protein.toString(), unit: 'proteins'),
          NutrientContent(value: nutrients.fats.toString(), unit: 'fats'),
          NutrientContent(value: nutrients.carbs.toString(), unit: 'carbs'),
        ],
      ),
    );
  }
}

class NutrientContent extends StatelessWidget {
  final String value;
  final String unit;
  const NutrientContent({
    super.key,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.bodyTextBold,
        ),
        Text(unit,
            style: AppTypography.labelText
                .copyWith(color: AppColors.charcoalBlack.withOpacity(0.2))),
      ],
    );
  }
}
