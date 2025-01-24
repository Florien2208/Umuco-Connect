// lib/services/api_config.dart
class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8000';
  static const int timeout = 30;

  static Map<String, String> getHeaders({String? token}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }
}
