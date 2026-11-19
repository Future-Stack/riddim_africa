import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/services/cache/storage_service.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/artist_entity.dart';
import '../../domain/usecases/get_home_products_usecase.dart';
import '../../domain/usecases/get_suggested_artists_usecase.dart';

class GlobalSearchController extends GetxController {
  final GetHomeProductsUseCase _getHomeProductsUseCase;
  final GetSuggestedArtistsUseCase _getSuggestedArtistsUseCase;

  GlobalSearchController(
    this._getHomeProductsUseCase,
    this._getSuggestedArtistsUseCase,
  );

  // Text controller
  final TextEditingController searchBarController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;

  // Search State
  final RxString searchText = ''.obs;
  final RxList<String> recentSearches = <String>[].obs;

  // Suggested Lists (all items)
  final RxList<ProductEntity> allProducts = <ProductEntity>[].obs;
  final RxList<ArtistEntity> allArtists = <ArtistEntity>[].obs;

  // Filtered Lists (search results)
  final RxList<ProductEntity> filteredProducts = <ProductEntity>[].obs;
  final RxList<ArtistEntity> filteredArtists = <ArtistEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load recent searches from local storage
    recentSearches.value = StorageService.getRecentSearches();

    // Setup listener on search text controller
    searchBarController.addListener(() {
      searchText.value = searchBarController.text;
      _filterResults();
    });

    // Fetch initial suggestions
    _loadSuggestions();
  }

  @override
  void onClose() {
    searchBarController.dispose();
    super.onClose();
  }

  Future<void> _loadSuggestions() async {
    isLoading.value = true;
    try {
      final results = await Future.wait([
        _getHomeProductsUseCase.execute(),
        _getSuggestedArtistsUseCase.execute(),
      ]);

      allProducts.value = results[0] as List<ProductEntity>;
      allArtists.value = results[1] as List<ArtistEntity>;

      _filterResults();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load suggestions');
    } finally {
      isLoading.value = false;
    }
  }

  void _filterResults() {
    final query = searchText.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredProducts.clear();
      filteredArtists.clear();
    } else {
      filteredProducts.value = allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query) ||
              product.subtitle.toLowerCase().contains(query) ||
              product.categoryText.toLowerCase().contains(query))
          .toList();

      filteredArtists.value = allArtists
          .where((artist) =>
              artist.name.toLowerCase().contains(query) ||
              artist.genre.toLowerCase().contains(query))
          .toList();
    }
  }

  // Action methods
  void onSearchSubmitted(String query) {
    final trimmed = query.trim();
    if (trimmed.isNotEmpty) {
      addRecentSearch(trimmed);
    }
  }

  void selectRecentSearch(String query) {
    searchBarController.text = query;
    searchBarController.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
  }

  void addRecentSearch(String query) {
    // Remove if already exists to move it to the top
    recentSearches.remove(query);
    // Insert at the beginning of the list
    recentSearches.insert(0, query);

    // Limit to 10 items
    if (recentSearches.length > 10) {
      recentSearches.removeLast();
    }

    StorageService.saveRecentSearches(recentSearches);
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
    StorageService.saveRecentSearches(recentSearches);
  }

  void clearRecentSearches() {
    recentSearches.clear();
    StorageService.saveRecentSearches(recentSearches);
  }
}
