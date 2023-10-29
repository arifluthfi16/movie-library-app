import 'package:dio/dio.dart';
import 'package:movie_library/api/RequestWrapper.dart';

import '../dto/AuthDTO.dart';

class AuthAPI {
  static const String baseUrl = "http://moviegateway.galakita.com/auth";

  static Future<UserResponseDTO> getCurrentUser() async {
    try {
      RequestWrapper dio = RequestWrapper();
      final response = await dio.get('$baseUrl/me');
      if (response.statusCode == 200) {
        return UserResponseDTO.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<LoginResponseDTO> login(String username, String password) async {
    final data = {
      'username': username,
      'password': password,
    };

    try {
      final dio = Dio();

      final response = await dio.post(
        '$baseUrl/login',
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 401) {
        return LoginResponseDTO.fromJson(response.data);
      } else {
        throw Exception('Authentication failed');
      }
    } catch (e) {
      throw Exception('Failed to send data: $e');
    }
  }

}