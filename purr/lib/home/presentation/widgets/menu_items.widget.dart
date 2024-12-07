import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/typography.dart';
import 'package:purr/design_system/widgets/responsive_sized_box.widget.dart';
import 'package:purr/design_system/widgets/rounded_edge_button.widget.dart';
import 'package:purr/home/core/types/menu_item.type.dart';
import 'package:purr/home/presentation/cubit/menu_cubit.dart';
import 'package:purr/home/presentation/widgets/item_details.widget.dart';

class MenuItemList extends StatelessWidget {
  final List<MenuItem> menuItems;

  const MenuItemList({super.key, required this.menuItems});

  void _showBottomSheet(BuildContext context, MenuItem item) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: MenuItemDetails(
                item: item,
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
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return GestureDetector(
          onTap: () => _showBottomSheet(
            context,
            item,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Item Image
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 25,
                        offset: Offset(-2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.asset(
                      item.imageUrl,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                // Item Details
                Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: AppTypography.labelText.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          RoundedEdgeButton(
                            text: item.price.toString(),
                            bgColor: AppColors.charcoalBlack.withOpacity(0.1),
                            textColor: AppColors.charcoalBlack,
                            onTap: () {},
                          ),
                          const ResponsiveSizedBox(
                            width: 16,
                          ),
                          Text(
                            '${item.nutrients.kcal} kcal',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    AppColors.charcoalBlack.withOpacity(0.25)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
