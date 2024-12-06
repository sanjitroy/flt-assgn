import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purr/appbar/appbar.widget.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_demensions.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/theme.dart';
import 'package:purr/design_system/typography.dart';
import 'package:purr/design_system/widgets/responsive_sized_box.widget.dart';
import 'package:purr/design_system/widgets/rounded_edge_button.widget.dart';
import 'package:purr/home/core/types/menu_item.type.dart';
import 'package:purr/home/presentation/cubit/menu_cubit.dart';
import 'package:purr/home/presentation/cubit/menu_state.dart';
import 'package:purr/home/presentation/widgets/gradient_container_with_overflow_image.widget.dart';
import 'package:purr/images.dart';
import 'package:purr/mocks/mockData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

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
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        GradientCarousel(),
                        // GradientContainerWithOverflowingImage(
                        //     title: 'Two slices of pizza with delicious salami',
                        //     buttonText: '\$21.78',
                        //     imageUrl: AssetImages.saladImage,
                        //     onButtonPressed: () {}),
                        // GradientCarousel(),
                        ResponsiveSizedBox(
                          height: 24,
                        ),
                        FilterChipsWidget(),
                        ResponsiveSizedBox(
                          height: 8,
                        ),
                        MenuItemList(
                          menuItems: state.menuItems,
                        ),
                        ResponsiveSizedBox(
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

class GradientCarousel extends StatefulWidget {
  @override
  State<GradientCarousel> createState() => _GradientCarouselState();
}

class _GradientCarouselState extends State<GradientCarousel> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    MockMenuService().fetchMenu();
    return FutureBuilder(
      future: MockMenuService().fetchMenu(),
      builder: (BuildContext context, AsyncSnapshot<List<MenuItem>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.sublist(0, 4);
          return Column(
            children: [
              CarouselSlider.builder(
                carouselController: _controller,
                itemCount: data.length,
                itemBuilder: (context, index, realIndex) {
                  final item = data[index];
                  return Padding(
                    padding: ResponsiveEdgeInsets.symmetric(
                      context,
                      vertical: 12,
                    ),
                    child: GradientContainerWithOverflowingImage(
                      title: item.description,
                      buttonText: '\$${item.price}',
                      imageUrl: item.imageUrl,
                      onButtonPressed: () {
                        print('${item.id} button pressed');
                      },
                    ),
                  );
                },
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  height:
                      ResponsiveDimensions.getProportionalHeight(context, 0.3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              Padding(
                padding: ResponsiveEdgeInsets.symmetric(context,
                    vertical: 0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: data.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Expanded(
                        child: Container(
                          width: ResponsiveDimensions.getResponsiveWidth(
                            context,
                            75,
                          ),
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _currentIndex == entry.key
                                  ? AppColors.charcoalBlack
                                  : AppColors.charcoalBlack.withOpacity(0.2)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Container(),
          );
        }
      },
    );
  }
}

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
              // height: MediaQuery.of(context).size.height *
              //     0.75,
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.asset(
                      item.imageUrl,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black12,
                        blurRadius: 25,
                        offset: Offset(-2, 2),
                      ),
                    ],
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
                          ResponsiveSizedBox(
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
                    // height: MediaQuery.of(context).size.height *
                    //     0.75, // 3/4th screen height
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

class CheckoutWidget extends StatelessWidget {
  final MenuCubit menuCubit;
  const CheckoutWidget({
    super.key,
    required this.menuCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      bloc: menuCubit,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: ResponsiveEdgeInsets.symmetric(
              context,
              horizontal: 16,
              vertical: 28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We will deliver in\n24 minutes to the address: ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ResponsiveSizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Text(
                      '100a Ealing Rd',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const ResponsiveSizedBox(width: 8),
                    const Text(
                      'Change address',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                ResponsiveSizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: state.cart.isNotEmpty,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          (state.cart.isNotEmpty) ? state.cart.length : 0,
                      itemBuilder: (context, index) {
                        if (state.cart.isEmpty) {
                          return const Center(
                            child: Text('No items in cart'),
                          );
                          // Navigator.pop(context);
                        } else {
                          return Container(
                            padding: ResponsiveEdgeInsets.symmetric(
                              context,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child: Image.asset(
                                      state.cart[index].menuItem.imageUrl,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 25,
                                        offset: Offset(-2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                ResponsiveSizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.cart[index].menuItem.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (state.cart[index].quantity >
                                                  0)
                                                menuCubit.updateCartItem(
                                                    state.cart[index].menuItem,
                                                    state.cart[index].quantity -
                                                        1);
                                            },
                                            child: Container(
                                              padding: ResponsiveEdgeInsets
                                                  .symmetric(
                                                context,
                                                horizontal: 6,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: AppColors.charcoalBlack
                                                      .withOpacity(0.05),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Icon(
                                                Icons.remove,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            state.cart[index].quantity
                                                .toString(),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 12),
                                          // Plus button
                                          GestureDetector(
                                            onTap: () {
                                              menuCubit.updateCartItem(
                                                  state.cart[index].menuItem,
                                                  state.cart[index].quantity +
                                                      1);
                                            },
                                            child: Container(
                                                padding: ResponsiveEdgeInsets
                                                    .symmetric(
                                                  context,
                                                  horizontal: 6,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .charcoalBlack
                                                        .withOpacity(0.05),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 18,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '\$${state.cart[index].menuItem.price * state.cart[index].quantity}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                ),

                Divider(
                  color: AppColors.charcoalBlack.withOpacity(0.1),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 70,
                        child: Center(
                          child: Icon(
                            Icons.fork_right,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // const SizedBox(width: 16),
                      ResponsiveSizedBox(
                        width: 32,
                      ),
                      const Expanded(
                        child: Text(
                          'Cutlery',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: ResponsiveEdgeInsets.symmetric(
                                context,
                                horizontal: 6,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                  color:
                                      AppColors.charcoalBlack.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '1',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: ResponsiveEdgeInsets.symmetric(
                                context,
                                horizontal: 6,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                  color:
                                      AppColors.charcoalBlack.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.charcoalBlack.withOpacity(0.1),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Free delivery from \$30',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        '\$0.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                ResponsiveSizedBox(
                  height: 64,
                ),
                Text('Payment method'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.payment_outlined,
                        color: Colors.black54,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Apple pay',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black54,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                ResponsiveSizedBox(
                  height: 16,
                ),
                FloatingButton(
                  title: 'Pay',
                  amountToPay: (state.cart.isNotEmpty)
                      ? state.cart
                          .map(
                            (e) => (e.menuItem.price * e.quantity),
                          )
                          .reduce((value, element) => value + element)
                          .toString()
                      : '0',
                ),
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(12),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.2),
                //         spreadRadius: 2,
                //         blurRadius: 5,
                //         offset: const Offset(0, 3),
                //       ),
                //     ],
                //   ),
                //   child: const Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       // Cart text on the left
                //       Text(
                //         'Cart',
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black,
                //         ),
                //       ),

                //       // Time and price on the right
                //       Row(
                //         children: [
                //           Text(
                //             '24 mins',
                //             style: TextStyle(
                //               fontSize: 14,
                //               color: Colors.black54,
                //             ),
                //           ),
                //           SizedBox(width: 8),
                //           Text(
                //             '\$24',
                //             style: TextStyle(
                //               fontSize: 14,
                //               color: Colors.black54,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
