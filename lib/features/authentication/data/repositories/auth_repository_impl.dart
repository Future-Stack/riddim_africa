import 'package:riddimafrica/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riddimafrica/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:riddimafrica/core/models/response_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<ResponseData> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<ResponseData> register(Map<String, dynamic> body, {String role = 'User'}) async {
    return await remoteDataSource.register(body, role: role);
  }

  @override
  Future<ResponseData> verifyOtp({
    required String email,
    required String otp,
    String otpType = 'REGISTRATION',
  }) async {
    return await remoteDataSource.verifyOtp(
      email: email,
      otp: otp,
      otpType: otpType,
    );
  }

  @override
  Future<ResponseData> resendOtp(String email) async {
    return await remoteDataSource.resendOtp(email);
  }

  @override
  Future<ResponseData> forgotPassword(String email) async {
    return await remoteDataSource.forgotPassword(email);
  }

  @override
  Future<ResponseData> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    return await remoteDataSource.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }
}
