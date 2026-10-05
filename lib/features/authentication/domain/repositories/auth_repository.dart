import 'package:riddimafrica/core/models/response_data.dart';

abstract class AuthRepository {
  Future<ResponseData> login(String email, String password);
  Future<ResponseData> register(Map<String, dynamic> body, {String role = 'User'});
  Future<ResponseData> verifyOtp({
    required String email,
    required String otp,
    String otpType,
  });
  Future<ResponseData> resendOtp(String email);
  Future<ResponseData> forgotPassword(String email);
  Future<ResponseData> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  });
}
