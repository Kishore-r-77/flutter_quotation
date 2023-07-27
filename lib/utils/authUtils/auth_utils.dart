import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static const String endPoint = '/auth/signin';

  // Keys to store and fetch data from SharedPreferences
  static const String authTokenKey = 'authToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String phone = 'phone';
  static const String nameKey = 'username';

  static String? getAuthToken(SharedPreferences prefs) {
    return prefs.getString(authTokenKey);
  }

  static String? getRefreshToken(SharedPreferences prefs) {
    return prefs.getString(refreshTokenKey);
  }

  static insertDetails(SharedPreferences prefs, response) {
    prefs.setString(authTokenKey, response['authToken']);
    prefs.setString(refreshTokenKey, response['refreshToken']);
    prefs.setString(phone, response['phone']);
    prefs.setString(nameKey, response['name']);
  }

  static insertAuthToken(SharedPreferences prefs, String token) {
    prefs.setString(authTokenKey, token);
  }

  static deleteDetails(SharedPreferences prefs) {
    prefs.clear();
  }
}
