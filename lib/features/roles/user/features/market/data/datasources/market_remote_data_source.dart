import 'dart:developer';
import 'package:riddimafrica/core/services/network/network_caller.dart';
import 'package:riddimafrica/core/utils/constants/api_constants.dart';
import '../models/market_product_model.dart';
import '../models/cart_item_model.dart';
import '../models/delivery_address_model.dart';
import '../models/checkout_result_model.dart';

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

  Future<bool> addToCart({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  });

  Future<List<CartItemModel>> getCart();

  Future<List<DeliveryAddressModel>> getShippingAddresses();

  Future<DeliveryAddressModel> saveShippingAddress(
    DeliveryAddressModel address,
  );

  Future<DeliveryAddressModel> updateShippingAddress(
    String id,
    DeliveryAddressModel address,
  );

  Future<CheckoutResultModel> processCheckout({
    required String? shippingInfoId,
    required Map<String, dynamic> shippingDetails,
    required String paymentMethod,
    required String checkoutType,
    Map<String, dynamic>? directPurchase,
  });
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

  @override
  Future<bool> addToCart({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'productId': productId,
        'quantity': quantity,
      };
      if (color != null && color.isNotEmpty) {
        body['color'] = color;
      }
      if (size != null && size.isNotEmpty) {
        body['size'] = size;
      }

      final response = await _networkCaller.postRequest(
        ApiConstants.userCart,
        body: body,
      );

      if (response.isSuccess) {
        return true;
      }
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to add item to cart',
      );
    } catch (e, stack) {
      log('MarketRemoteDataSourceImpl.addToCart error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<List<CartItemModel>> getCart() async {
    try {
      final response = await _networkCaller.getRequest(
        ApiConstants.userCart,
      );

      if (response.isSuccess && response.responseData != null) {
        final rawData = response.responseData;
        dynamic itemsJson;

        if (rawData is Map<String, dynamic>) {
          if (rawData['data'] is Map<String, dynamic>) {
            itemsJson = rawData['data']['items'];
          } else if (rawData['data'] is List) {
            itemsJson = rawData['data'];
          } else if (rawData['items'] is List) {
            itemsJson = rawData['items'];
          }
        }

        if (itemsJson is List) {
          return itemsJson
              .whereType<Map<String, dynamic>>()
              .map((item) => CartItemModel.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e, stack) {
      log('MarketRemoteDataSourceImpl.getCart error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<List<DeliveryAddressModel>> getShippingAddresses() async {
    try {
      final response = await _networkCaller.getRequest(
        ApiConstants.userShippingInfo,
      );

      if (response.isSuccess && response.responseData != null) {
        final rawData = response.responseData;
        dynamic listJson;

        if (rawData is Map<String, dynamic>) {
          listJson = rawData['data'];
        } else if (rawData is List) {
          listJson = rawData;
        }

        if (listJson is List) {
          return listJson
              .whereType<Map<String, dynamic>>()
              .map((item) => DeliveryAddressModel.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (e, stack) {
      log('MarketRemoteDataSourceImpl.getShippingAddresses error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<DeliveryAddressModel> saveShippingAddress(
    DeliveryAddressModel address,
  ) async {
    try {
      final response = await _networkCaller.postRequest(
        ApiConstants.userShippingInfo,
        body: address.toJson(),
      );

      if (response.isSuccess && response.responseData != null) {
        final rawData = response.responseData;
        Map<String, dynamic>? dataJson;
        if (rawData is Map<String, dynamic>) {
          if (rawData['data'] is Map<String, dynamic>) {
            dataJson = rawData['data'] as Map<String, dynamic>;
          } else {
            dataJson = rawData;
          }
        }
        if (dataJson != null) {
          return DeliveryAddressModel.fromJson(dataJson);
        }
      }
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to save shipping address',
      );
    } catch (e, stack) {
      log('MarketRemoteDataSourceImpl.saveShippingAddress error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<DeliveryAddressModel> updateShippingAddress(
    String id,
    DeliveryAddressModel address,
  ) async {
    try {
      final response = await _networkCaller.patchRequest(
        ApiConstants.userShippingInfoDetail(id),
        body: address.toJson(),
      );

      if (response.isSuccess && response.responseData != null) {
        final rawData = response.responseData;
        Map<String, dynamic>? dataJson;
        if (rawData is Map<String, dynamic>) {
          if (rawData['data'] is Map<String, dynamic>) {
            dataJson = rawData['data'] as Map<String, dynamic>;
          } else {
            dataJson = rawData;
          }
        }
        if (dataJson != null) {
          return DeliveryAddressModel.fromJson(dataJson);
        }
      }
      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to update shipping address',
      );
    } catch (e, stack) {
      log('MarketRemoteDataSourceImpl.updateShippingAddress error: $e\n$stack');
      rethrow;
    }
  }

  @override
  Future<CheckoutResultModel> processCheckout({
    required String? shippingInfoId,
    required Map<String, dynamic> shippingDetails,
    required String paymentMethod,
    required String checkoutType,
    Map<String, dynamic>? directPurchase,
  }) async {
    try {
      final Map<String, dynamic> body = {
        if (shippingInfoId != null && shippingInfoId.isNotEmpty)
          'shippingInfoId': shippingInfoId,
        'shippingDetails': shippingDetails,
        'paymentMethod': paymentMethod,
        'checkoutType': checkoutType,
      };

      if (directPurchase != null) {
        body['directPurchase'] = directPurchase;
      }

      final response = await _networkCaller.postRequest(
        ApiConstants.userCheckoutProcess,
        body: body,
      );

      if (response.isSuccess && response.responseData != null) {
        final rawData = response.responseData;
        Map<String, dynamic>? dataJson;
        if (rawData is Map<String, dynamic>) {
          if (rawData['data'] is Map<String, dynamic>) {
            dataJson = rawData['data'] as Map<String, dynamic>;
          } else {
            dataJson = rawData;
          }
        }
        if (dataJson != null) {
          return CheckoutResultModel.fromJson(dataJson);
        }
      }

      throw Exception(
        response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Checkout process failed',
      );
    } catch (e, stack) {
      log('MarketRemoteDataSourceImpl.processCheckout error: $e\n$stack');
      rethrow;
    }
  }
}
