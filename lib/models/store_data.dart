
import 'product.dart';
import 'category.dart';

class StoreData {
  final String storeName;
  final String heroBannerTitle;
  final String heroBannerImageUrl;
  final String newCollectionLabel;
  final String newCollectionTitle;
  final String newCollectionImageUrl;
  final List<Map<String, dynamic>> topCollections;
  final List<Map<String, dynamic>> categoryPromos;
  final List<Category> categories;
  final List<Product> products;


  StoreData({
    required this.storeName,
    required this.heroBannerTitle,
    required this.heroBannerImageUrl,
    required this.newCollectionLabel,
    required this.newCollectionTitle,
    required this.newCollectionImageUrl,
    required this.categories,
    required this.products,
    required this.topCollections,
    required this.categoryPromos,
  });


  factory StoreData.fromJson(Map<String, dynamic> json) {
    final homePage = json['homePage'] as Map<String, dynamic>;
    final heroBanner = homePage['heroBanner'] as Map<String, dynamic>;
    final newCollection = homePage['newCollection'] as Map<String, dynamic>;


    final categoriesJson = homePage['categories'] as List<dynamic>;
    final featureProductsJson =
    homePage['featureProducts'] as List<dynamic>;
    final recommendedJson =
    homePage['recommended'] as List<dynamic>;

    return StoreData(

      storeName: homePage['storeName'] as String,
      heroBannerTitle: heroBanner['title'] as String,
      heroBannerImageUrl: heroBanner['imageUrl'] as String,
      newCollectionLabel: newCollection['label'] as String,
      newCollectionTitle: newCollection['title'] as String,
      newCollectionImageUrl: newCollection['imageUrl'] as String,

      topCollections: (homePage['topCollections'] as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),

      categoryPromos: (homePage['categoryPromos'] as List<dynamic>)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),

      categories: categoriesJson
          .map((item) => Category.fromJson(
          item as Map<String, dynamic>))
          .toList(),
      products: [
        ...featureProductsJson.map(
              (item) => Product.fromJson(
              item as Map<String, dynamic>),
        ),
        ...recommendedJson.map(
              (item) => Product.fromJson(
              item as Map<String, dynamic>),
        ),
      ],
    );
  }
}
