import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/typography.dart';
import 'package:purr/design_system/widgets/responsive_sized_box.widget.dart';
import 'package:purr/home/core/types/menu_item.type.dart';
import 'package:purr/home/presentation/cubit/menu_cubit.dart';
import 'package:purr/home/presentation/cubit/menu_state.dart';
import 'package:purr/home/presentation/widgets/nutrient_card.widget.dart';

class MenuItemDetails extends StatelessWidget {
  final MenuItem item;
  final MenuCubit menuCubit;
  const MenuItemDetails({
    super.key,
    required this.item,
    required this.menuCubit,
  });

  @override
  Widget build(BuildContext context) {
    // final menuCubit = BlocProvider.of<MenuCubit>(context);
    return BlocBuilder<MenuCubit, MenuState>(
      bloc: menuCubit,
      builder: (context, state) {
        final quantity = state.tempQuantities[item.id] ?? 1;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset(
                        item.imageUrl,
                        height: 250,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ResponsiveSizedBox(height: 32),
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                ResponsiveSizedBox(height: 20),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                ResponsiveSizedBox(height: 20),
                NutrientCard(
                  nutrients: item.nutrients,
                ),
                ResponsiveSizedBox(
                  height: 16,
                ),
                ExpansionTile(
                  dense: true,
                  trailing: Icon(Icons.chevron_right),
                  title: Text(
                    'Add in ${item.name}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Container(),
                    ),
                  ],
                ),
                ResponsiveSizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: ResponsiveEdgeInsets.symmetric(context,
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.charcoalBlack.withOpacity(0.07)),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            color: AppColors.charcoalBlack.withOpacity(0.2),
                            onPressed: () {
                              if (quantity > 0)
                                menuCubit.updateTempQuantity(
                                    item, quantity - 1);
                            },
                          ),
                          ResponsiveSizedBox(
                            width: 8,
                          ),
                          Text(
                            '$quantity',
                            style:
                                AppTypography.labelText.copyWith(fontSize: 16),
                          ),
                          ResponsiveSizedBox(
                            width: 8,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: AppColors.charcoalBlack.withOpacity(0.8),
                            ),
                            onPressed: () {
                              menuCubit.updateTempQuantity(item, quantity + 1);
                            },
                          ),
                        ],
                      ),
                    ),
                    ResponsiveSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          menuCubit.addItemToCart(item);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.charcoalBlack,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: ResponsiveEdgeInsets.symmetric(context,
                              horizontal: 24, vertical: 16),
                          child: Row(
                            children: [
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(),
                              Text(
                                '\$${item.price * quantity}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ResponsiveSizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
