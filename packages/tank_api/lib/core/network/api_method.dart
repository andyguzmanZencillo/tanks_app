import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:failures/failures.dart';
import 'package:tank_api/core/encryption/encryption.dart';
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

  static Future<String> getToken({
    required Dio dio,
    required Uri uri,
    required Map<String, dynamic> data,
  }) async {
    try {
      dio.interceptors.add(ApiInterceptor());

      log('REQUEST TOKEN SED ===> ${jsonEncode(data)}');
      final response = await dio.post<String>(
        uri.toString(),
        data: jsonEncode(data),
      );

      final decoded = json.decode(response.data!);
      log('RESPONSE TOKEN ===> ${jsonEncode(decoded)}');
      final result = TokenResponse.fromJson(
        decoded as Map<String, dynamic>,
      );

      if (!result.response) throw RequestException();

      /*await saveLogger(
        statusCode: response.statusCode ?? 500,
        message: 'Token obtenido correctamente',
        title: data['Query'] as String?,
      );*/
      await _secure.write('token', result.token);
      return result.token;
    } on SocketException {
      throw const SocketException('');
    } on DioException catch (e) {
      log('EXCEPTION TOKEN ===> $e');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw const SocketException('');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NoInternetException();
      } else if (e.type == DioExceptionType.badResponse) {
        final data = e.response?.data as String;
        final decoded = jsonDecode(data) as Map<String, dynamic>;
        throw ResultException(decoded['Message'] as String);
      } else {
        throw RequestException();
      }
    }
  }

  static Future<String> post({
    required Dio dio,
    required Uri uri,
    required Map<String, dynamic> data,
  }) async {
    try {
      log('DATA SEND API ===> ${jsonEncode(data)}');

      dio.interceptors.add(TokenInterceptor());
      final response = await dio.post<String>(
        uri.toString(),
        data: jsonEncode(data),
      ); //.timeout(const Duration(seconds: 2));

      final decoded = jsonDecode(response.data!);
      log(json.toString());

      //final decrypted = decrypt(response.data!);
      //final decoded = jsonDecode(decrypted);
      log('RESPONSE ${data['Query']} ===> ${jsonEncode(decoded)}');

      final result = DataResponse.fromJson(
        decoded as Map<String, dynamic>,
      );

      if (!result.result) throw RequestException();

      final message = result.message ?? '';
      log('MESSAGE ${data['Query']} ===> $message');
      return 'sas';
    } on RequestException catch (e, stacktrace) {
      log('EXCEPTION ${data['Query']} ===> $e - $stacktrace');
      throw RequestException();
    } on DioException catch (e, stacktrace) {
      if (e.response?.statusCode == 403) {
        log('EXCEPTION ${e.response?.statusCode} ===> ${e.response}');
        //log('EXCEPTION ${data['Query']} ===> $e - $stacktrace');
        throw UnauthorizedException();
      } else {
        throw RequestException();
      }
    }
  }
}
