// data/datasource/remote/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:las_customer/core/util/secure_storage.dart';

class ApiService {
  // static String _baseUrl =
  //     'https://gomulung-backend-production.up.railway.app/api/v1';

  // android emulator
  static String _baseUrl = 'http://10.0.2.2:3000/api/v1';
  static final SecureStorage _secureStorage = SecureStorage();

  // Token retrieval method
  static Future<String?> getToken() async {
    return await _secureStorage.readSecureData(key: 'token');
  }

  static Future<http.Response> fetchData(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final token = await getToken(); // Get token from secure storage
    final response = await http.get(
      url,
      headers: {
        if (token != null) 'Authorization': token, // Include token if available
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<http.Response> postData(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final token = await getToken(); // Get token from secure storage

    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': token, // Include token if available
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 400 &&
        response.body.contains('TokenExpiredError')) {
      return response;
    } else {
      throw Exception('Failed to post data');
    }
  }

  static Future<http.Response> putData(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final token = await getToken(); // Get token from secure storage

    final response = await http.put(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': token, // Include token if available
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to put data');
    }
  }

  static Future<http.Response> deleteData(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final token = await getToken(); // Get token from secure storage

    final response = await http.delete(
      url,
      headers: {
        if (token != null) 'Authorization': token, // Include token if available
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to delete data');
    }
  }

  // File uploads
  static Future<http.Response> postFile(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    final token = await getToken(); // Get token from secure storage
    final request = http.MultipartRequest('POST', url);

    data.forEach((key, value) {
      request.files.add(http.MultipartFile.fromBytes(
        key,
        value,
        filename: key,
      ));
    });

    // Add token to the headers if available
    if (token != null) {
      request.headers['Authorization'] = token;
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      return http.Response.fromStream(response);
    } else {
      throw Exception('Failed to post file');
    }
  }
}
