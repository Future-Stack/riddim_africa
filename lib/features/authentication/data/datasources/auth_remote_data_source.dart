import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:riddimafrica/core/services/network/network_caller.dart';
import 'package:riddimafrica/core/models/response_data.dart';
import 'package:riddimafrica/core/utils/constants/api_constants.dart';

class AuthRemoteDataSource {
  final NetworkCaller _api;

  AuthRemoteDataSource(this._api);

  Future<ResponseData> register(Map<String, dynamic> body, {String role = 'User'}) async {
    final endpoint = switch (role.toLowerCase()) {
      'artist' => ApiConstants.registerArtist,
      'seller' => ApiConstants.registerSeller,
      _ => ApiConstants.registerUser,
    };

    if (role.toLowerCase() == 'seller' || role.toLowerCase() == 'artist') {
      final formDataMap = <String, dynamic>{};
      for (final entry in body.entries) {
        if (entry.value == null) continue;
        if (entry.key == 'frontSide' || entry.key == 'backSide') {
          final path = entry.value.toString();
          if (path.isNotEmpty && File(path).existsSync()) {
            formDataMap[entry.key] = await MultipartFile.fromFile(
              path,
              filename: path.split('/').last,
            );
          }
        } else if (entry.key == 'passportFiles' || entry.key == 'drivingLicenseFiles') {
          if (entry.value is List) {
            final files = <MultipartFile>[];
            for (final p in (entry.value as List)) {
              final path = p.toString();
              if (path.isNotEmpty && File(path).existsSync()) {
                files.add(await MultipartFile.fromFile(
                  path,
                  filename: path.split('/').last,
                ));
              }
            }
            if (files.isNotEmpty) {
              formDataMap[entry.key] = files;
            }
          }
        } else {
          formDataMap[entry.key] = entry.value.toString();
        }
      }

      final sanitizedLog = Map<String, dynamic>.from(body)
        ..['password'] = '********'
        ..['confirmPassword'] = '********';
      log('[AUTH API] POST ${role.toUpperCase()} Registration (FormData): $endpoint');
      log('[AUTH API] Payload fields: $sanitizedLog');

      final formData = FormData.fromMap(formDataMap);
      return await _api.postRequest(
        endpoint,
        body: formData,
      );
    }

    final sanitizedLog = Map<String, dynamic>.from(body)
      ..['password'] = '********'
      ..['confirmPassword'] = '********';
    log('[AUTH API] POST Registration: $endpoint');
    log('[AUTH API] Payload: $sanitizedLog');
    return await _api.postRequest(
      endpoint,
      body: body,
    );
  }

  Future<ResponseData> login(String email, String password) async {
    log('[AUTH API] POST Login: ${ApiConstants.login}');
    log('[AUTH API] Payload: {email: $email, password: [PROTECTED]}');
    return await _api.postRequest(
      ApiConstants.login,
      body: {'email': email, 'password': password},
    );
  }

  Future<ResponseData> verifyOtp({
    required String email,
    required String otp,
    String otpType = 'REGISTRATION',
  }) async {
    final body = {
      'email': email,
      'otp': otp,
      'otpType': otpType,
    };
    log('[AUTH API] POST Verify OTP: ${ApiConstants.verifyOtp}');
    log('[AUTH API] Payload: $body');
    return await _api.postRequest(
      ApiConstants.verifyOtp,
      body: body,
    );
  }

  Future<ResponseData> resendOtp(String email) async {
    final body = {'email': email};
    log('[AUTH API] POST Resend OTP: ${ApiConstants.resendOtp}');
    log('[AUTH API] Payload: $body');
    return await _api.postRequest(
      ApiConstants.resendOtp,
      body: body,
    );
  }

  Future<ResponseData> forgotPassword(String email) async {
    final body = {'email': email};
    log('[AUTH API] POST Forgot Password: ${ApiConstants.forgotPassword}');
    log('[AUTH API] Payload: $body');
    return await _api.postRequest(
      ApiConstants.forgotPassword,
      body: body,
    );
  }

  Future<ResponseData> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final body = {
      'resetToken': resetToken,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
    log('[AUTH API] POST Reset Password: ${ApiConstants.resetPassword}');
    log('[AUTH API] Payload: {resetToken: $resetToken, newPassword: [PROTECTED], confirmNewPassword: [PROTECTED]}');
    return await _api.postRequest(
      ApiConstants.resetPassword,
      body: body,
    );
  }
}
