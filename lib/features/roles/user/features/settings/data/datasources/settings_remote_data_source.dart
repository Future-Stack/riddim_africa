import 'dart:developer';
import 'package:riddimafrica/core/models/response_data.dart';
import 'package:riddimafrica/core/services/network/network_caller.dart';
import 'package:riddimafrica/core/utils/constants/api_constants.dart';

class SettingsRemoteDataSource {
  final NetworkCaller _api;

  SettingsRemoteDataSource([NetworkCaller? api]) : _api = api ?? NetworkCaller();

  Future<ResponseData> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final body = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
    log('[SETTINGS API] POST Change Password: ${ApiConstants.changePassword}');
    log('[SETTINGS API] Payload: {oldPassword: [PROTECTED], newPassword: [PROTECTED], confirmNewPassword: [PROTECTED]}');
    return await _api.postRequest(
      ApiConstants.changePassword,
      body: body,
    );
  }

  Future<ResponseData> deleteAccount({
    required String password,
  }) async {
    final body = {
      'password': password,
    };
    log('[SETTINGS API] DELETE Account: ${ApiConstants.deleteAccount}');
    log('[SETTINGS API] Payload: {password: [PROTECTED]}');
    return await _api.deleteRequest(
      ApiConstants.deleteAccount,
      body: body,
    );
  }
}
