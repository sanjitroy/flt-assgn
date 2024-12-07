import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purr/appbar/appbar.widget.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/typography.dart';
import 'package:purr/design_system/widgets/floating_button.widget.dart';
import 'package:purr/design_system/widgets/responsive_sized_box.widget.dart';
import 'package:purr/home/presentation/cubit/menu_cubit.dart';
import 'package:purr/home/presentation/cubit/menu_state.dart';
import 'package:purr/home/presentation/widgets/filter_chips.widget.dart';
import 'package:purr/home/presentation/widgets/gradient_carousel.widget.dart';
import 'package:purr/home/presentation/widgets/menu_items.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => MenuCubit()..loadMenu(),
        child: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!state.isLoading) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: ResponsiveEdgeInsets.symmetric(
                            context,
                            vertical: 16,
                            horizontal: 16,
                          ),
                          child: Text(
                            'Hits of the week',
                            style: AppTypography.headline1,
                          ),
                        ),
                        const GradientCarousel(),
                        const ResponsiveSizedBox(
                          height: 24,
                        ),
                        FilterChipsWidget(),
                        const ResponsiveSizedBox(
                          height: 8,
                        ),
                        MenuItemList(
                          menuItems: state.menuItems,
                        ),
                        const ResponsiveSizedBox(
                          height: 64,
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: state.cart.isNotEmpty,
                      child: FloatingButton(
                        amountToPay: (state.cart.isNotEmpty)
                            ? state.cart
                                .map((e) => e.menuItem.price * e.quantity)
                                .reduce((value, element) => value + element)
                                .toString()
                            : '0',
                      )),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
