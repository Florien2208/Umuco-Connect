// lib/services/base_api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseApiService {
  final _storage = SharedPreferences.getInstance();

  Future<String?> getToken() async {
    final prefs = await _storage;
    return prefs.getString('auth_token');
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final token = await getToken();
      final response = await http
          .get(
            Uri.parse(ApiConfig.baseUrl + endpoint),
            headers: ApiConfig.getHeaders(token: token),
          )
          .timeout(const Duration(seconds: ApiConfig.timeout));

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final token = await getToken();
      final response = await http
          .post(
            Uri.parse(ApiConfig.baseUrl + endpoint),
            headers: ApiConfig.getHeaders(token: token),
            body: json.encode(data),
          )
          .timeout(const Duration(seconds: ApiConfig.timeout));

      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Add other methods like put, delete, etc.

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return {'success': true, 'data': json.decode(response.body)};
    } else {
      return _handleError(response);
    }
  }

  Map<String, dynamic> _handleError(dynamic error) {
    if (error is http.Response) {
      try {
        final errorData = json.decode(error.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Server error',
          'errors': errorData['errors'],
        };
      } catch (_) {
        return {
          'success': false,
          'message': 'Server error: ${error.statusCode}',
        };
      }
    }
    return {
      'success': false,
      'message': 'Connection error: ${error.toString()}',
    };
  }
}
