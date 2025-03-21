import 'dart:convert';

import 'package:app/features/authentication/data/models/auth_token.dart';
import 'package:app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final AuthRepository authRepository;

  ApiService({
    required this.baseUrl,
    required this.authRepository,
  });

  // Method to get the auth token
  Future<String?> _getAuthToken() async {
    final AuthToken? authToken = await authRepository.checkAuthStatus();
    if (authToken != null) {
      // Check if token is expired
      if (DateTime.now().millisecondsSinceEpoch < authToken.expiresAt * 1000) {
        return authToken.accessToken;
      }
    }
    return null;
  }

  // Generic GET request with authentication
  Future<Map<String, dynamic>> get(String endpoint) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      _handleApiError(response);
      throw Exception('API request failed');
    }
  }

  // Generic POST request with authentication
  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      _handleApiError(response);
      throw Exception('API request failed');
    }
  }

  // Generic PUT request with authentication
  Future<Map<String, dynamic>> put(
      String endpoint, Map<String, dynamic> body) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      _handleApiError(response);
      throw Exception('API request failed');
    }
  }

  // Generic DELETE request with authentication
  Future<Map<String, dynamic>> delete(String endpoint) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      _handleApiError(response);
      throw Exception('API request failed');
    }
  }

  // Handle API errors
  void _handleApiError(http.Response response) {
    try {
      final errorData = jsonDecode(response.body);
      if (response.statusCode == 401) {
        // Token might be expired, try to sign out
        authRepository.signOut();
      }
      // You can handle specific error codes here
      print('API Error: ${errorData['message'] ?? 'Unknown error'}');
    } catch (e) {
      print('Failed to parse error response: $e');
    }
  }
}
