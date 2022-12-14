import 'package:dio/dio.dart';
import 'package:todofrog_client/config/config.dart';

class Client {
  Client() {
    initClient();
  }

  late Dio _dio;

  void initClient() {
    final accessToken = Storage.prefs.getString('access_token');
    final dioOptions = BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
        'Authorization': 'Bearer $accessToken'
      },
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.add(LogInterceptor());
  }

  Future<Map<String, dynamic>> get({
    required String path,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(path);
      return response.data ?? {};
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(path, data: data);
      return response.data ?? {};
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(path, data: data);
      return response.data ?? {};
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response =
          await _dio.delete<Map<String, dynamic>>(path, data: data);
      return response.data ?? {};
    } catch (_) {
      rethrow;
    }
  }
}
