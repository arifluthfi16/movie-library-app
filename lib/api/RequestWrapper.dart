import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RequestWrapper {
  final Dio _dio = Dio();

  final _storage = const FlutterSecureStorage();

  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> setAuthToken(String authToken) async {
    await _storage.write(key: 'auth_token', value: authToken);
  }

  Future<void> clearAuthToken() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<void> refreshAuthToken(String newToken) async {
    await clearAuthToken();
    await setAuthToken(newToken);
  }

  Future<Response<T>> get<T>(String path) async {
    final authToken = await getAuthToken();
    _dio.options.headers['Authorization'] = 'Bearer $authToken';
    return _dio.get(path);
  }

  Future<Response<T>> post<T>(String path, dynamic data) async {
    final authToken = await getAuthToken();
    _dio.options.headers['Authorization'] = 'Bearer $authToken';
    return _dio.post(path, data: data);
  }

  Future<Response<T>> put<T>(String path, dynamic data) async {
    final authToken = await getAuthToken();
    _dio.options.headers['Authorization'] = 'Bearer $authToken';
    return _dio.put(path, data: data);
  }

  Future<Response<T>> delete<T>(String path) async {
    final authToken = await getAuthToken();
    _dio.options.headers['Authorization'] = 'Bearer $authToken';
    return _dio.delete(path);
  }
}
