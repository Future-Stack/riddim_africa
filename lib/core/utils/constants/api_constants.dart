class ApiConstants {
  static const String baseUrl = "http://15.240.117.162:5000/api/v1";

  static String get registerUser => "$baseUrl/auth/register/user";
  static String get registerArtist => "$baseUrl/auth/register/artist";
  static String get registerSeller => "$baseUrl/auth/register/seller";
  static String get register => registerUser;
  static String get login => "$baseUrl/auth/login";
  static String get forgotPassword => "$baseUrl/auth/forgot-password";
  static String get verifyOtp => "$baseUrl/auth/verify-otp";
  static String get resendOtp => "$baseUrl/auth/resend-otp";
  static String get resetPassword => "$baseUrl/auth/reset-password";
  static String get refreshToken => "$baseUrl/auth/refresh-token";
  static String get businessTypes => "$baseUrl/admin/business-types";
  static String get userProfile => "$baseUrl/user/profile";
  static String get changePassword => "$baseUrl/auth/change-password";
  static String get deleteAccount => "$baseUrl/auth/delete-account";
  static String get userProducts => "$baseUrl/user/products";
  static String userProductDetails(String productId) => "$baseUrl/user/products/$productId";
}