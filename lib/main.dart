import 'package:flutter/material.dart';
import 'product_page.dart'; //spre pagina 2//
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/home/home_cubit.dart';
import 'cubits/home/home_state.dart';
import 'widgets/loading_widget.dart';
import 'widgets/empty_widget.dart';
import 'widgets/error_widget.dart' as store_error;
import 'widgets/category_item.dart';


void main() {
  runApp(const GemStoreApp());
}

class GemStoreApp extends StatelessWidget { //configurare aplicatie
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
//schimbari //
        home: BlocProvider(
          create: (context) => HomeCubit()..loadProducts(),
          child: const HomePage(),
        ),

    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
return BlocBuilder<HomeCubit, HomeState>(
builder: (context, state) {
if (state is HomeLoading || state is HomeInitial) {
return const Scaffold(
body: LoadingWidget(),
);
}

if (state is HomeEmpty) {
return const Scaffold(
body: EmptyWidget(),
);
}

if (state is HomeError) {
return Scaffold(
body: store_error.ErrorWidget(message: state.message),
);
}

//adaugare
if (state is! HomeSuccess) {
  return const Scaffold(
    body: LoadingWidget(),
  );
}

  final products = state.filteredProducts;

return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: TextField(
                  onChanged: (value) {
                    context.read<HomeCubit>().searchProducts(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: state.storeData.categories.map((category) {
                    IconData categoryIcon;

                    switch (category.id) {
                      case 'women':
                        categoryIcon = Icons.female;
                        break;
                      case 'men':
                        categoryIcon = Icons.male;
                        break;
                      case 'accessories':
                        categoryIcon = Icons.directions_bike;
                        break;
                      case 'beauty':
                        categoryIcon = Icons.brush_outlined;
                        break;
                      default:
                        categoryIcon = Icons.category_outlined;
                    }

                    return CategoryItem(
                      icon: categoryIcon,
                      title: category.name,
                      selected: state.selectedCategory == category.id,
                      onTap: () {
                        context.read<HomeCubit>().filterByCategory(category.id);
                      },
                    );
                  }).toList(),
                ),
              ),


              const SizedBox(height: 25),



              // Autumn Collection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    children: [
                      Image.network(
                        state.storeData.heroBannerImageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/autumn_collection1.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        left: 20,
                        bottom: 20,
                        right: 20,
                        child: Text(
                          state.storeData.heroBannerTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              const SizedBox(height: 25),//pt spatiu

              // Feature Products
              // Feature Products
              const SectionTitle(title: 'Feature Products'),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.sort, size: 20),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      tooltip: 'Sort products',
                      onSelected: (value) {
                        context.read<HomeCubit>().sortProducts(value);
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'priceAsc',
                          child: Text('Price: Low to High'),
                        ),
                        const PopupMenuItem(
                          value: 'priceDesc',
                          child: Text('Price: High to Low'),
                        ),
                        const PopupMenuItem(
                          value: 'name',
                          child: Text('Name: A-Z'),
                        ),
                      ],
                      child: const Text('Sort by'),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 15),
//in caz ca nu sunt produse
              if (products.isEmpty)
                const SizedBox(
                  height: 235,
                  child: EmptyWidget(),
                )
              else
              SizedBox(
                height: 235,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 24),
//citire din json
                  children: products.take(3).map((product) {


                    return ProductCard(
                      image: product.imageUrl,
                      name: product.name,
                      price: '\$ ${product.price.toStringAsFixed(2)}',
                      isFavorite: state.favoriteIds.contains(product.id),
                      onFavoriteTap: () {
                        context.read<HomeCubit>().toggleFavorite(product.id);
                      },
                      onTap: product.id == 'p003'
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductPage(),
                          ),
                        );
                      }
                          : null,
                    );
                  }).toList(),

                ),   // închide ListView
              ),     // închide SizedBox

              const SizedBox(height: 10),


              // Hang Out & Party
              Stack(
                children: [
                  Image.network(
                    state.storeData.newCollectionImageUrl,
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const SizedBox(
                        height: 230,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/hang_out_party_3.png',
                        width: double.infinity,
                        height: 230,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Positioned(
                    left: 24,
                    bottom: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.storeData.newCollectionLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.storeData.newCollectionTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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


              Column(
                children: state.storeData.topCollections.map((collection) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Image.network(
                            collection['imageUrl'] as String,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/frame_33170last.png',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Positioned(
                            left: 20,
                            bottom: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  collection['label'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  collection['title'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black54,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),


// Category Promos
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Category Promos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Column(
                children: state.storeData.categoryPromos.map((promo) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Image.network(
                            promo['imageUrl'] as String,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                height: 180,
                                child: Center(
                                  child: Icon(Icons.broken_image_outlined),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: 20,
                            bottom: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  promo['category'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  promo['title'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black54,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            ],
          ),
        ),
      ),
);
},
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



class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Imaginea produsului + Favorite
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    width: 140,
                    height: 175,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const SizedBox(
                        width: 140,
                        height: 175,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        width: 140,
                        height: 175,
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),

                // Inimioara din coltul imaginii
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite
                            ? Colors.red
                            : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Denumirea produsului
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 4),

            // Pretul produsului
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

