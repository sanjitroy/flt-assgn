import 'package:flutter/material.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/typography.dart';
import 'package:purr/design_system/widgets/responsive_sized_box.widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: ResponsiveEdgeInsets.symmetric(
                  context,
                  vertical: 8,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.charcoalBlack,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '100a Ealing Rd',
                      style: AppTypography.bodyText,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const ResponsiveSizedBox(width: 8),
                    Text(
                      '\u2022',
                      style: AppTypography.headline2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const ResponsiveSizedBox(width: 8),
                    Text(
                      '24 mins',
                      style: AppTypography.bodyText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Search Icon
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );
}
