import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:riddimafrica/core/models/response_data.dart';
import 'package:riddimafrica/core/services/network/network_caller.dart';
import 'package:riddimafrica/core/utils/constants/api_constants.dart';

class ProfileRemoteDataSource {
  final NetworkCaller _api;

  ProfileRemoteDataSource([NetworkCaller? api]) : _api = api ?? NetworkCaller();

  Future<ResponseData> getUserProfile() async {
    log('[PROFILE API] GET User Profile: ${ApiConstants.userProfile}');
    return await _api.getRequest(ApiConstants.userProfile);
  }

  Future<ResponseData> updateProfile({
    String? fullName,
    String? username,
    String? phoneNumber,
    String? country,
    String? city,
    String? stateName,
    String? stageName,
    String? genre,
    String? bio,
    String? profileImagePath,
  }) async {
    final Map<String, dynamic> map = {};
    if (fullName != null && fullName.isNotEmpty) map['fullName'] = fullName;
    if (username != null && username.isNotEmpty) map['username'] = username;
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      map['phoneNumber'] = phoneNumber;
    }
    if (country != null && country.isNotEmpty) map['country'] = country;
    if (city != null && city.isNotEmpty) map['city'] = city;
    if (stateName != null && stateName.isNotEmpty) map['stateName'] = stateName;
    if (stageName != null && stageName.isNotEmpty) map['stageName'] = stageName;
    if (genre != null && genre.isNotEmpty) map['genre'] = genre;
    if (bio != null && bio.isNotEmpty) map['bio'] = bio;

    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      final file = File(profileImagePath);
      if (file.existsSync()) {
        map['profileImage'] = await MultipartFile.fromFile(
          profileImagePath,
          filename: profileImagePath.split('/').last,
        );
      }
    }

    final formData = FormData.fromMap(map);
    log('[PROFILE API] PATCH User Profile (multipart/form-data): ${ApiConstants.userProfile}');
    log('[PROFILE API] Fields: ${formData.fields}');
    return await _api.patchRequest(ApiConstants.userProfile, body: formData);
  }
}
