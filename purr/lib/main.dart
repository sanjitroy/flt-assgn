import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Hits of the week'),
                SizedBox(height: 32),
                GradientCarousel(),
                FilterChipsWidget(),
                MenuItemList(),
              ],
            ),
          ),
          const FloatingCartBar(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0, // Remove default spacing
      backgroundColor: Colors.white, // Adjust based on your design system
      elevation: 2, // Add shadow for depth
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Implement menu action here
            },
          ),
          // Address Container
          const Expanded(
            child: Center(
              child: const Text(
                '1234 Elm Street, Springfield, IL 62701',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis, // Prevent overflow issues
              ),
            ),
          ),
          // Search Icon
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Implement search action here
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight,
      );
}

class GradientContainerWithImage extends StatelessWidget {
  final String title;
  final String buttonText;
  final String imageUrl; // URL or asset path for the image
  final VoidCallback onButtonPressed;

  GradientContainerWithImage({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.imageUrl,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allows image to overflow outside the container
      children: [
        Container(
          height: 200, // Adjust container height
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orangeAccent, // Start color
                Colors.deepOrange, // End color
              ],
            ),
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Bottom-left text
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Bottom-right button
              ElevatedButton(
                onPressed: onButtonPressed, // No const here
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button color
                  foregroundColor: Colors.deepOrange, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ),
        // Positioned image, overflowing at the top
        Positioned(
          top: -30, // Adjusts image overlap outside the container
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 100, // Adjust image size
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Circular image
                image: DecorationImage(
                  image: NetworkImage(
                      imageUrl), // Replace with NetworkImage for URLs
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GradientCarousel extends StatelessWidget {
  final List<Map<String, String>> carouselItems = [
    {
      "title": "Delicious Meals",
      "buttonText": "Order Now",
      "imageUrl": "https://picsum.photos/200"
    },
    {
      "title": "Healthy Salads",
      "buttonText": "Explore",
      "imageUrl": "https://picsum.photos/200"
    },
    {
      "title": "Tasty Desserts",
      "buttonText": "Try Now",
      "imageUrl": "https://picsum.photos/200"
    },
    {
      "title": "Refreshing Drinks",
      "buttonText": "Check Out",
      "imageUrl": "https://picsum.photos/200"
    },
    {
      "title": "Special Deals",
      "buttonText": "Grab Now",
      "imageUrl": "https://picsum.photos/200"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider.builder(
        itemCount: carouselItems.length,
        itemBuilder: (context, index, realIndex) {
          final item = carouselItems[index];
          return GradientContainerWithImage(
            title: item["title"]!,
            buttonText: item["buttonText"]!,
            imageUrl: item["imageUrl"]!,
            onButtonPressed: () {
              // Implement specific actions per item if needed
              print('${item["title"]} button pressed');
            },
          );
        },
        options: CarouselOptions(
          // height: 250, // Adjust the height as needed
          // enlargeCenterPage: true,
          enableInfiniteScroll: false,
// viewportFraction: 32,
          // autoPlay: false,
          // viewportFraction: 0, // Adjust for spacing between items
          // autoPlayInterval: Duration(seconds: 4),
          // autoPlayAnimationDuration: Duration(milliseconds: 800),
          // autoPlayCurve: Curves.fastOutSlowIn,
          // enableInfiniteScroll: true,
        ),
      ),
    );
  }
}

class FilterChipsWidget extends StatefulWidget {
  @override
  _FilterChipsWidgetState createState() => _FilterChipsWidgetState();
}

class _FilterChipsWidgetState extends State<FilterChipsWidget> {
  // List of filter options
  final List<String> filterOptions = [
    'All',
    'Veg',
    'Non-Veg',
    'Drinks',
    'Desserts',
    'Specials',
  ];

  // Track selected filters
  final Set<String> selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling
        child: Row(
          children: filterOptions.map((filter) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: FilterChip(
                label: Text(filter),
                selected: selectedFilters.contains(filter),
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      selectedFilters.add(filter); // Add to selected filters
                    } else {
                      selectedFilters
                          .remove(filter); // Remove from selected filters
                    }
                  });
                  // Optionally, perform an action with selected filters
                  print(selectedFilters);
                },
                backgroundColor: Colors.grey[200],
                selectedColor: Colors.deepOrangeAccent,
                labelStyle: TextStyle(
                  color: selectedFilters.contains(filter)
                      ? Colors.white
                      : Colors.black,
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
  // Sample list of menu items
  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Grilled Chicken",
      "price": "\$12.99",
      "calories": "350 kcal",
      "imageUrl": "https://picsum.photos/100", // Placeholder image URL
    },
    {
      "title": "Vegetarian Pizza",
      "price": "\$10.49",
      "calories": "400 kcal",
      "imageUrl": "https://picsum.photos/100",
    },
    {
      "title": "Caesar Salad",
      "price": "\$8.99",
      "calories": "250 kcal",
      "imageUrl": "https://picsum.photos/100",
    },
    {
      "title": "Chocolate Cake",
      "price": "\$6.50",
      "calories": "450 kcal",
      "imageUrl": "https://picsum.photos/100",
    },
  ];

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor:
          Colors.transparent, // Transparent background to see outside content
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none, // Allows bar to overflow outside
          children: [
            // Bottom Sheet Content
            Container(
              height: MediaQuery.of(context).size.height *
                  0.75, // 3/4th screen height
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: BottomSheetContent(),
            ),
            // Draggable bar outside on top
            Positioned(
              top: -15, // Positioned outside the top border
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
      shrinkWrap: true, // Ensures it takes only necessary space inside a Column
      physics:
          NeverScrollableScrollPhysics(), // Disable internal scrolling if nested
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: Image.network(
                    item["imageUrl"],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 64), // Spacing between image and text
                // Item Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        item["title"],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Spacing between title and info row
                      // Price and Calories Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item["price"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            item["calories"],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
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

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top Image
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.network(
              'https://picsum.photos/200', // Placeholder image URL
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          // Title Text
          const Text(
            'Item Title',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 10),

          // Description Text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'This is a brief description of the item. It gives details about the features, ingredients, or other important information.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Container with 5 Texts in a Row
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Detail 1', style: TextStyle(fontSize: 14)),
                Text('Detail 2', style: TextStyle(fontSize: 14)),
                Text('Detail 3', style: TextStyle(fontSize: 14)),
                Text('Detail 4', style: TextStyle(fontSize: 14)),
                Text('Detail 5', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          ExpansionTile(
            title: const Text(
              'More Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'This is additional information about the item. You can add details like ingredients, nutritional values, or any other relevant data.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Counter Button with (-) and (+)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        // Logic to decrement count
                      },
                    ),
                    const Text(
                      '1', // Initial value; this will be dynamic
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Logic to increment count
                      },
                    ),
                  ],
                ),
              ),

              // Add to Cart Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Customize as needed
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Logic to add item to cart
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FloatingCartBar extends StatelessWidget {
  const FloatingCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Covers most of the screen
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (BuildContext context) {
              return CheckoutWidget();
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
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
              // Cart Text
              const Text(
                'Cart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // Right-aligned text: time and cost
              Row(
                children: const [
                  Text(
                    '24 mins',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 12), // Spacing between time and price
                  Text(
                    '\$24',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
  const CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkout Title
          Center(
            child: Text(
              'Checkout',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16), // Spacer between elements

          // Address Text
          Text(
            'Delivery Address:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8), // Spacer below address label
          Text(
            '123 Main Street, Springfield, USA', // Replace with dynamic data
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image on the left
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://picsum.photos/80',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16), // Space between image and column

                // Column with text and counter
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item title
                      const Text(
                        'Delicious Burger', // Replace with dynamic data
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Spacer between title and counter

                      // Counter row
                      Row(
                        children: [
                          // Minus button
                          GestureDetector(
                            onTap: () {
                              // Handle decrement logic here
                            },
                            child: const Icon(Icons.remove_circle_outline),
                          ),
                          const SizedBox(
                              width: 12), // Space between buttons and number
                          const Text(
                            '1', // Replace with dynamic count value
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 12),
                          // Plus button
                          GestureDetector(
                            onTap: () {
                              // Handle increment logic here
                            },
                            child: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Text on the right
                const Text(
                  '\$12', // Replace with dynamic price data
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon on the left
                const Icon(
                  Icons.fastfood, // Replace with your desired icon
                  size: 30,
                  color: Colors.black,
                ),
                const SizedBox(width: 16), // Space between icon and text

                // Text in the middle
                const Expanded(
                  child: Text(
                    'Extra Sauce', // Replace with dynamic text
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Counter on the right
                Row(
                  children: [
                    // Minus button
                    GestureDetector(
                      onTap: () {
                        // Handle decrement logic here
                      },
                      child: const Icon(Icons.remove_circle_outline),
                    ),
                    const SizedBox(
                        width: 12), // Space between buttons and number
                    const Text(
                      '1', // Replace with dynamic count value
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 12),
                    // Plus button
                    GestureDetector(
                      onTap: () {
                        // Handle increment logic here
                      },
                      child: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Column on the left with two texts
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Item Details:', // Replace with dynamic text
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8), // Spacer between texts
                    Text(
                      'Tasty burger with fries', // Replace with dynamic text
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),

                const Spacer(), // Spacer to push the text on the right to the far end of the Row

                // Text on the right
                const Text(
                  'Additional details here...', // Replace with dynamic text
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon on the left
                const Icon(
                  Icons.location_on, // Replace with your desired icon
                  color: Colors.black54,
                  size: 24,
                ),

                // Text beside the icon
                const SizedBox(width: 8), // Spacer between the icon and text
                const Text(
                  'Delivery Address', // Replace with dynamic text
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const Spacer(), // Spacer to push the next icon to the far right

                // Icon on the right
                const Icon(
                  Icons.arrow_forward_ios, // Replace with your desired icon
                  color: Colors.black54,
                  size: 24,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // Cart text on the left
                Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                // Time and price on the right
                Row(
                  children: [
                    Text(
                      '24 mins',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '\$24',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
