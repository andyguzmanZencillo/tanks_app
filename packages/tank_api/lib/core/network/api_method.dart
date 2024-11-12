import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:failures/failures.dart';
import 'package:tank_api/core/encryption/encryption.dart';
import 'package:tank_api/core/extends/json_extends.dart';
import 'package:tank_api/core/models/default_response.dart';
import 'package:tank_api/core/network/api_interceptor.dart';
import 'package:tank_api/core/storage/secure.dart';

class ApiMethod {
  static final _secure = Secure.instance;

  //static final _storage = Storage.instance;

  static String encrypt(String data) {
    return Encryption.encrypt(data);
  }

  static String decrypt(String data) {
    return Encryption.decrypt(data);
  }

  static Future<TokenResponse> getToken({
    required Dio dio,
    required Uri uri,
    required Map<String, dynamic> data,
  }) async {
    try {
      dio.interceptors.add(ApiInterceptor());

      log('REQUEST TOKEN SED ===> ${jsonEncode(data)}');
      final response = await dio
          .post<String>(
            uri.toString(),
            data: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 2));

      final decoded = json.decode(response.data!);
      log('RESPONSE TOKEN ===> ${jsonEncode(decoded)}');
      final result = TokenResponse.fromJson(
        decoded as Map<String, dynamic>,
      );

      //if (!result.response) throw RequestException();

      /*await saveLogger(
        statusCode: response.statusCode ?? 500,
        message: 'Token obtenido correctamente',
        title: data['Query'] as String?,
      );*/
      await _secure.write('token', result.token);
      return result;
    } on DioException catch (e) {
      log('EXCEPTION TOKEN ===> $e');
      if (e.type == DioExceptionType.badResponse) {
        final data = e.response?.data as String;
        final decoded = jsonDecode(data) as Map<String, dynamic>;
        throw InvalidDataException(decoded['Message'] as String);
      } else {
        throw NetworkRequestException();
      }
    }
  }

  static Future<DataResponse> post({
    required Dio dio,
    required Uri uri,
    required Map<String, dynamic> data,
    String? requestName,
  }) async {
    try {
      log('DATA SEND API $requestName ===> ${jsonEncode(data)}');

      dio.interceptors.add(TokenInterceptor());
      final response = await dio.post<String>(
        uri.toString(),
        data: jsonEncode(data),
      );

      final decoded = jsonDecode(response.data!);

      log('RESPONSE $requestName ===> ${jsonEncode(decoded)}');
      final map = decoded as Map<String, dynamic>;

      if (map.containsKey('result')) {
        final r = map
            .getPro<Map<String, dynamic>>('result', {}).getPro('token', false);
        if (!r) {
          throw UnauthorizedAccessException();
        }
      }
      final result = DataResponse.fromJson(
        decoded,
      );

      final message = result.message;
      log('MESSAGE $requestName ===> $message');
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw UnauthorizedAccessException();
      } else {
        throw NetworkRequestException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
