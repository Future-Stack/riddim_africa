import 'dart:developer';
import 'package:riddimafrica/core/services/network/network_caller.dart';
import 'package:riddimafrica/core/utils/constants/api_constants.dart';
import '../models/market_product_model.dart';

abstract class MarketRemoteDataSource {
  Future<List<MarketProductModel>> getProducts({
    int page = 1,
    int limit = 10,
    String? search,
    String? categoryId,
    String? collectionId,
    String? collectionTitle,
  });

  Future<MarketProductModel> getProductDetails(String productId);
}

class MarketRemoteDataSourceImpl implements MarketRemoteDataSource {
  final NetworkCaller _networkCaller;

  MarketRemoteDataSourceImpl({NetworkCaller? networkCaller})
      : _networkCaller = networkCaller ?? NetworkCaller();

  @override
  Future<List<MarketProductModel>> getProducts({
    int page = 1,
    int limit = 10,
    String? search,
    String? categoryId,
    String? collectionId,
    String? collectionTitle,
  }) async {
    final Map<String, dynamic> queryParams = {
      'page': page,
      'limit': limit,
    };

    if (search != null && search.trim().isNotEmpty) {
      queryParams['search'] = search.trim();
    }
    if (categoryId != null && categoryId.trim().isNotEmpty) {
      queryParams['categoryId'] = categoryId.trim();
    }
    if (collectionId != null && collectionId.trim().isNotEmpty) {
      queryParams['collectionId'] = collectionId.trim();
    }
    if (collectionTitle != null && collectionTitle.trim().isNotEmpty) {
      queryParams['collectionTitle'] = collectionTitle.trim();
    }

    try {
      final response = await _networkCaller.getRequest(
        ApiConstants.userProducts,
        queryParameters: queryParams,
      );

      if (response.isSuccess && response.responseData != null) {
        final rawData = response.responseData;
        dynamic productsJson;

        if (rawData is Map<String, dynamic>) {
          if (rawData['data'] is Map<String, dynamic>) {
            productsJson = rawData['data']['products'];
          } else if (rawData['data'] is List) {
            productsJson = rawData['data'];
          } else if (rawData['products'] is List) {
            productsJson = rawData['products'];
          }
        }

        if (productsJson is List) {
          return productsJson
              .whereType<Map<String, dynamic>>()
              .map((item) => MarketProductModel.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e, stack) {
      log('MarketRemoteDataSourceImpl.getProducts error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<MarketProductModel> getProductDetails(String productId) async {
    try {
      final response = await _networkCaller.getRequest(
        ApiConstants.userProductDetails(productId),
      );

      if (response.isSuccess && response.responseData != null) {
        final rawData = response.responseData;
        Map<String, dynamic>? productJson;

        if (rawData is Map<String, dynamic>) {
          if (rawData['data'] is Map<String, dynamic>) {
            productJson = rawData['data'] as Map<String, dynamic>;
          } else {
            productJson = rawData;
          }
        }

        if (productJson != null) {
          return MarketProductModel.fromJson(productJson);
        }
      }

      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to retrieve product details',
      );
    } catch (e, stack) {
      log('MarketRemoteDataSourceImpl.getProductDetails error: $e\n$stack');
      rethrow;
    }
  }
}
