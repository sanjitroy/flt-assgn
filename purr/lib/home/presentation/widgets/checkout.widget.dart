import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/design_system/widgets/floating_button.widget.dart';
import 'package:purr/design_system/widgets/responsive_sized_box.widget.dart';
import 'package:purr/home/presentation/cubit/menu_cubit.dart';
import 'package:purr/home/presentation/cubit/menu_state.dart';

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
              ],
            ),
          ),
        );
      },
    );
  }
}
