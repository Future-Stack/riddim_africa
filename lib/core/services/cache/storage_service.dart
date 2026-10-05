import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Constants for preference keys
  static const String _tokenKey = 'token';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _idKey = 'userId';
  static const String _emailKey = 'userEmail';
  static const String _roleKey = 'userRole';

  // Singleton instance for SharedPreferences
  static SharedPreferences? _preferences;

  // Initialize SharedPreferences (call this during app startup)
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Check if a token exists in local storage
  static bool hasToken() {
    final token = _preferences?.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  // Save the token and user ID to local storage
  static Future<void> saveToken(String token, String id) async {
    await _preferences?.setString(_tokenKey, token);
    await _preferences?.setString(_idKey, id);
  }

  // Save full auth data
  static Future<void> saveAuthData({
    required String accessToken,
    String? refreshToken,
    String? userId,
    String? email,
    String? role,
  }) async {
    await _preferences?.setString(_tokenKey, accessToken);
    if (refreshToken != null) {
      await _preferences?.setString(_refreshTokenKey, refreshToken);
    }
    if (userId != null) {
      await _preferences?.setString(_idKey, userId);
    }
    if (email != null) {
      await _preferences?.setString(_emailKey, email);
    }
    if (role != null) {
      await _preferences?.setString(_roleKey, role);
    }
  }

  // Remove the token and user ID from local storage (for logout)
  static Future<void> logoutUser() async {
    await _preferences?.remove(_tokenKey);
    await _preferences?.remove(_refreshTokenKey);
    await _preferences?.remove(_idKey);
    await _preferences?.remove(_emailKey);
    await _preferences?.remove(_roleKey);
  }

  // Getter for user ID
  static String? get userId => _preferences?.getString(_idKey);

  // Getter for token
  static String? get token => _preferences?.getString(_tokenKey);

  // Getter for refresh token
  static String? get refreshToken => _preferences?.getString(_refreshTokenKey);

  // Getter for email
  static String? get email => _preferences?.getString(_emailKey);

  // Getter for role
  static String? get role => _preferences?.getString(_roleKey);

  // Recent Searches cache methods
  static const String _recentSearchesKey = 'recent_searches';

  static List<String> getRecentSearches() {
    return _preferences?.getStringList(_recentSearchesKey) ?? [];
  }

  static Future<void> saveRecentSearches(List<String> searches) async {
    await _preferences?.setStringList(_recentSearchesKey, searches);
  }
}


