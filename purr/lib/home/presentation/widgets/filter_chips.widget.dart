import 'package:flutter/material.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/typography.dart';

class FilterChipsWidget extends StatelessWidget {
  final List<String> filterOptions = [
    'All',
    'Salads',
    'Pizza',
    'Beverages',
    'Snacks',
    'Drinks',
  ];

  final Set<String> selectedFilters = {};

  FilterChipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filterOptions.map((filter) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.charcoalBlack.withOpacity(0.1)),
                padding: ResponsiveEdgeInsets.symmetric(
                  context,
                  vertical: 10,
                  horizontal: 14,
                ),
                child: Text(
                  filter,
                  style: AppTypography.labelText,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
