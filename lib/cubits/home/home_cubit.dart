
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/json_loader.dart';
import '../../models/store_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> loadProducts() async {
    emit(HomeLoading());

    try {
      final jsonData = await JsonLoader.loadStoreData();

      final storeData = StoreData.fromJson(jsonData);

      if (storeData.products.isEmpty) {
        emit(HomeEmpty());
      } else {
        emit(HomeSuccess(storeData));
      }
    } catch (e) {
      emit(HomeError('Eroare la incarcarea produselor: $e'));
    }
  }
//cautare produse



  void searchProducts(String query) {
    final currentState = state;

    if (currentState is HomeSuccess) {
      final searchText = query.trim().toLowerCase();

      final filteredProducts = currentState.storeData.products
          .where((product) =>
      product.categoryId == currentState.selectedCategory &&
          product.name.toLowerCase().contains(searchText))
          .toList();

      emit(
        HomeSuccess(
          currentState.storeData,
          filteredProducts: filteredProducts,
          favoriteIds: currentState.favoriteIds,
          selectedCategory: currentState.selectedCategory,
          searchQuery: query,
        ),
      );
    }
  }


//functia adaugare la favorite
  void toggleFavorite(String productId) {
    final currentState = state;

    if (currentState is HomeSuccess) {
      final updatedFavorites = Set<String>.from(
        currentState.favoriteIds,
      );

      if (updatedFavorites.contains(productId)) {
        updatedFavorites.remove(productId);
      } else {
        updatedFavorites.add(productId);
      }


      emit(
        HomeSuccess(
          currentState.storeData,
          filteredProducts: currentState.filteredProducts,
          favoriteIds: updatedFavorites,
          selectedCategory: currentState.selectedCategory,
          searchQuery: currentState.searchQuery,
        ),
      );
    }
  }

  void sortProducts(String sortType) {
    final currentState = state;

    if (currentState is HomeSuccess) {
      final sortedProducts = List.of(
        currentState.filteredProducts,
      );

      if (sortType == 'priceAsc') {
        sortedProducts.sort(
              (a, b) => a.price.compareTo(b.price),
        );
      } else if (sortType == 'priceDesc') {
        sortedProducts.sort(
              (a, b) => b.price.compareTo(a.price),
        );
      } else if (sortType == 'name') {
        sortedProducts.sort(
              (a, b) => a.name.compareTo(b.name),
        );
      }


      emit(
        HomeSuccess(
          currentState.storeData,
          filteredProducts: sortedProducts,
          favoriteIds: currentState.favoriteIds,
          selectedCategory: currentState.selectedCategory,
          searchQuery: currentState.searchQuery,
        ),
      );
    }
  }



  void filterByCategory(String categoryId) {
    final currentState = state;

    if (currentState is HomeSuccess) {
      final searchText = currentState.searchQuery.trim().toLowerCase();

      final filteredProducts = currentState.storeData.products
          .where((product) =>
      product.categoryId == categoryId &&
          product.name.toLowerCase().contains(searchText))
          .toList();

      emit(
        HomeSuccess(
          currentState.storeData,
          filteredProducts: filteredProducts,
          favoriteIds: currentState.favoriteIds,
          selectedCategory: categoryId,
          searchQuery: currentState.searchQuery,
        ),
      );
    }
  }



}
