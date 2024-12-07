import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_demensions.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/typography.dart';
import 'package:purr/design_system/widgets/responsive_sized_box.widget.dart';
import 'package:purr/home/presentation/cubit/menu_cubit.dart';
import 'package:purr/home/presentation/widgets/checkout.widget.dart';

class FloatingButton extends StatelessWidget {
  final bool generateLongButton;
  final String title;
  final String amountToPay;
  const FloatingButton({
    super.key,
    required this.amountToPay,
    this.generateLongButton = true,
    this.title = 'Cart',
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ResponsiveDimensions.getResponsiveHeight(
        context,
        28,
      ),
      left: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) {
              if (BlocProvider.of<MenuCubit>(context).state.cart.isEmpty) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: CheckoutWidget(
                      menuCubit: BlocProvider.of<MenuCubit>(context),
                    ),
                  ),
                  Positioned(
                    top: -15,
                    left: MediaQuery.of(context).size.width / 2 - 25,
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          padding: ResponsiveEdgeInsets.symmetric(context,
              horizontal: 20, vertical: 12),
          height: ResponsiveDimensions.getResponsiveHeight(
            context,
            54,
          ),
          decoration: BoxDecoration(
            color: AppColors.charcoalBlack,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.bodyText.copyWith(
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    '24 mins',
                    style: AppTypography.bodyText.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const ResponsiveSizedBox(width: 8),
                  Text(
                    '\u2022',
                    style: AppTypography.headline2.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const ResponsiveSizedBox(width: 8),
                  Text(
                    '\$$amountToPay',
                    style: AppTypography.bodyText.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
