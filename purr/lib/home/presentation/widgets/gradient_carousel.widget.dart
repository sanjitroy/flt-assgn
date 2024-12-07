import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:purr/design_system/colors.dart';
import 'package:purr/design_system/responsiveness/responsive_demensions.dart';
import 'package:purr/design_system/responsiveness/responsive_padding.dart';
import 'package:purr/home/core/types/menu_item.type.dart';
import 'package:purr/home/presentation/widgets/gradient_container_with_overflow_image.widget.dart';
import 'package:purr/mocks/mockData.dart';

class GradientCarousel extends StatefulWidget {
  const GradientCarousel({super.key});

  @override
  State<GradientCarousel> createState() => _GradientCarouselState();
}

class _GradientCarouselState extends State<GradientCarousel> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
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
