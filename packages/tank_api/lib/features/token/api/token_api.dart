import 'package:dio/dio.dart';
import 'package:tank_api/core/network/api_method.dart';
import 'package:tank_api/core/network/endpoints.dart';
import 'package:tank_api/features/token/models/token_request.dart';

class TokenApi {
  TokenApi({
    Dio? dio,
  }) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<String> getToken({
    required String idCompany,
    required String user,
    required String password,
  }) async {
    try {
      final response = await ApiMethod.getToken(
        dio: _dio,
        uri: Uri.http(
          Endpoints.authority,
          Endpoints.token,
        ),
        data: TokenRequest(
          idCompany: idCompany,
          user: user,
          password: password,
        ).toJson(),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
