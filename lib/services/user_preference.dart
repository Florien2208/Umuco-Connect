import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  factory UserPreferences() => _instance;
  UserPreferences._internal();

  // Keys for storing user data
  static const String _tokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _roleKey = 'user_role';

  // Save full user data after login
  Future<void> saveUserData(Map<String, dynamic> loginResponse) async {
    final prefs = await SharedPreferences.getInstance();

    // Save access token
    await prefs.setString(_tokenKey, loginResponse['access_token']);

    // Save user details
    await prefs.setString(_userDataKey, json.encode(loginResponse['user']));

    // Save user role for easy access
    await prefs.setString(_roleKey, loginResponse['user']['roleId'] ?? '');
  }

  // Retrieve stored user data
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString(_userDataKey);

    if (userDataJson != null) {
      return json.decode(userDataJson);
    }
    return null;
  }

  // Get specific user details
  Future<String?> getUserDetail(String key) async {
    final userData = await getUserData();
    return userData?[key];
  }

  // Get authentication token
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get user role
  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }
  

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  // Clear user data on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
    await prefs.remove(_roleKey);
  }
}
