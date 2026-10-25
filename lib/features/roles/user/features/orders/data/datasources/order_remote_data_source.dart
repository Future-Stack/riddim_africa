import 'dart:developer';
import 'package:riddimafrica/core/services/network/network_caller.dart';
import 'package:riddimafrica/core/utils/constants/api_constants.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders({String status = 'All'});
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final NetworkCaller _networkCaller;

  OrderRemoteDataSourceImpl({NetworkCaller? networkCaller})
      : _networkCaller = networkCaller ?? NetworkCaller();

  @override
  Future<List<OrderModel>> getOrders({String status = 'All'}) async {
    try {
      final response = await _networkCaller.getRequest(
        ApiConstants.userOrders,
        queryParameters: {'status': status},
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
              .map((json) => OrderModel.fromJson(json))
              .toList();
        }
      }
      return [];
    } catch (e, stack) {
      log('OrderRemoteDataSourceImpl.getOrders error: $e\n$stack');
      rethrow;
    }
  }
}
