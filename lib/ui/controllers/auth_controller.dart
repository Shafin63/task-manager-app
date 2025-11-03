import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';

class AuthController {
  static const String _accessTokenKey = 'token';
  static const String _userModelKey = 'user-data';

  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;
  }
  static Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));
    userModel = model;
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final String? token = sharedPreferences.getString(_accessTokenKey);
      if (token != null && token.isNotEmpty) {
        final String? userData = sharedPreferences.getString(_userModelKey);
        if (userData != null && userData.isNotEmpty) {
          final decoded = jsonDecode(userData);
          if (decoded is Map<String, dynamic>) {
            userModel = UserModel.fromJson(decoded);
          } else if (decoded is Map) {
            // jsonDecode can return Map<dynamic, dynamic> depending on source;
            userModel = UserModel.fromJson(Map<String, dynamic>.from(decoded));
          } else {
            userModel = null;
          }
        } else {
          userModel = null;
        }
        accessToken = token;
      } else {
        // no token stored
        accessToken = null;
        userModel = null;
      }
    } catch (e) {
      // In case of corrupted JSON or unexpected data, clear in-memory values.
      accessToken = null;
      userModel = null;
    }
  }

  static Future<bool> isUserAlreadyLoggedIn() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString(_accessTokenKey);
      return token  != null && token.isNotEmpty;
    } catch (e) {
      // If anything goes wrong reading preferences, treat as not logged in.
      return false;
    }
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}