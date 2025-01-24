import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:umuco_connect_hub/services/api_endpoints.dart';

import 'api_config.dart';

class RoleService {
  Future<String?> getRoleName(String roleId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.baseUrl + ApiEndpoints.getRole + '/${roleId}'),
      );
     
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        return data['data']['roleName']; // Assuming the API returns role name
      }
      return null;
    } catch (e) {
      print('Error fetching role: $e');
      return null;
    }
  }
}
