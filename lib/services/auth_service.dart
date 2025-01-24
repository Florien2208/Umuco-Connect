// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';
import 'api_endpoints.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final _storage = SharedPreferences.getInstance();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse(ApiConfig.baseUrl + ApiEndpoints.login),
            body: json.encode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: ApiConfig.timeout));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _saveAuthData(data);
        return {'success': true, 'data': data};
      } else {
        return _handleError(response);
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData) async {
    print('auth Data0000000000000: $userData');
    try {
      final response = await http
          .post(
            Uri.parse(ApiConfig.baseUrl + ApiEndpoints.signup),
            body: json.encode(userData),
          )
          .timeout(const Duration(seconds: ApiConfig.timeout));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        await _saveAuthData(data);
        return {'success': true, 'data': data};
      } else {
        print("Signup failed with response: ${response.body}");
        return _handleError(response);
      }
    } catch (e) {
      print("Signup failed with response: $e");
      return {'success': false, 'message': 'Connection error: ${e.toString()}'};
    }
  }

  Future<bool> logout() async {
    try {
      final prefs = await _storage;
      final token = prefs.getString('auth_token');

      if (token != null) {
        final response = await http.post(
          Uri.parse(ApiConfig.baseUrl + ApiEndpoints.logout),
          headers: ApiConfig.getHeaders(token: token),
        );

        await _clearAuthData();
        return response.statusCode == 200;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _saveAuthData(Map<String, dynamic> data) async {
    final prefs = await _storage;
    await prefs.setString('auth_token', data['token']);
    await prefs.setString('user_data', json.encode(data['user']));
  }

  Future<void> _clearAuthData() async {
    final prefs = await _storage;
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
  }

  Map<String, dynamic> _handleError(http.Response response) {
    try {
      final error = json.decode(response.body);
      return {
        'success': false,
        'message': error['message'] ?? 'Unknown error occurred',
        'errors': error['errors'],
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Server error: ${response.statusCode}',
      };
    }
  }
}
