import 'package:dio/dio.dart';
import 'package:tank_api/core/storage/secure.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.contentType = 'application/json';
    super.onRequest(options, handler);
  }
}

class TokenInterceptor extends Interceptor {
  final _secure = Secure.instance;
  final dio = Dio();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (await _secure.hasKey('token')) {
      final token = await _secure.read('token');
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.contentType = 'application/json';
    super.onRequest(options, handler);
  }
}
