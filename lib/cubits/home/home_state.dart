
import '../../models/store_data.dart';
import '../../models/product.dart';

// Clasa de baza pentru toate starile
abstract class HomeState {}

// Starea initiala
class HomeInitial extends HomeState {}

// Datele se incarca
class HomeLoading extends HomeState {}

// Datele au fost incarcate cu succes




class HomeSuccess extends HomeState {
  final StoreData storeData;
  final List<Product> filteredProducts;
  final Set<String> favoriteIds;
  final String selectedCategory;
  final String searchQuery;

  HomeSuccess(
      this.storeData, {
        List<Product>? filteredProducts,
        Set<String>? favoriteIds,
        this.selectedCategory = 'women',
        this.searchQuery = '',
      })  : filteredProducts = filteredProducts ?? storeData.products,
        favoriteIds = favoriteIds ?? {};
}




// Nu exista produse de afisat
class HomeEmpty extends HomeState {}

// A aparut o eroare
class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
