import 'package:flutter/material.dart';
import 'product_page.dart'; //spre pagina 2//

void main() {
  runApp(const GemStoreApp());
}

class GemStoreApp extends StatelessWidget {
  const GemStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GemStore',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Bara de sus
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu),

                    const Text(
                      'GemStore',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Stack(
                      children: [
                        const Icon(Icons.notifications_none),
                        Positioned(
                          right: 1,
                          top: 1,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Categorii
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryItem(
                      icon: Icons.female,
                      title: 'Women',
                      selected: true,
                    ),
                    CategoryItem(
                      icon: Icons.male,
                      title: 'Men',
                    ),
                    CategoryItem(
                      icon: Icons.directions_bike,
                      title: 'Accessories',
                    ),
                    CategoryItem(
                      icon: Icons.brush_outlined,
                      title: 'Beauty',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Autumn Collection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/images/autumn_collection1.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Feature Products
              // Feature Products
              const SectionTitle(title: 'Feature Products'),

              const SizedBox(height: 15),

              SizedBox(
                height: 235,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 24),
                  children: [
                    const ProductCard(
                      image: 'assets/images/feature _1.png',
                      name: 'Turtleneck Sweater',
                      price: '\$ 39.99',
                    ),

                    const ProductCard(
                      image: 'assets/images/feature_2.png',
                      name: 'Long Sleeve Dress',
                      price: '\$ 45.00',
                    ),

                    ProductCard(
                      image: 'assets/images/feature_3.png',
                      name: 'Sportswear Set',
                      price: '\$ 80.00',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductPage(),
                          ),
                        );
                      },
                    ),
                  ], // închide children
                ),   // închide ListView
              ),     // închide SizedBox

              const SizedBox(height: 10),

              // Hang Out & Party
              Image.asset(
                'assets/images/hang_out_party_3.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 25),

              // Recommended
              const SectionTitle(title: 'Recommended'),

              const SizedBox(height: 15),

              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 24),
                  children: const [
                    RecommendedCard(
                      image: 'assets/images/banner_1.png',
                    ),
                    RecommendedCard(
                      image: 'assets/images/banner_2.png',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Top Collection
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Top Collection',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Image.asset(
                  'assets/images/frame_33170last.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


//4 cercuri cu categorii de sus.//
class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF3A332E)
                : const Color(0xFFF5F5F5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 22,
            color: selected ? Colors.white : Colors.grey,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: selected ? Colors.black87 : Colors.grey,
          ),
        ),
      ],
    );
  }
}


///sectionTitle //
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Show all',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

//featureProducts//
class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  //// Funcție opțională care se execută la apăsarea pe produs
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    //
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //
    return GestureDetector(
        onTap: onTap,
        child: Container(
      width: 140,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 140,
              height: 175,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    );
  }
}

//recommended card//
class RecommendedCard extends StatelessWidget {
  final String image;

  const RecommendedCard({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

