import 'package:dio/dio.dart';
import 'package:tank_api/core/network/api_method.dart';
import 'package:tank_api/core/network/endpoints.dart';
import 'package:tank_api/features/company/models/company_request.dart';

class CompanyApi extends BaseApi {
  Future<String> saveCompany(
    InsertCompanyRequest insertCompanyRequest,
  ) async {
    try {
      final response = await post(
        insertCompanyRequest.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class BaseApi {
  BaseApi({
    Dio? dio,
  }) : _dio = dio ?? Dio();

  final Dio _dio;
  Future<String> post(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await ApiMethod.post(
        dio: _dio,
        uri: Uri.http(
          Endpoints.authority,
          Endpoints.command,
        ),
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

/*
Future<T> handleExceptionApi<T>(
  Future<T> Function() action,
) async {
  try {
    final response = await ApiMethod.post(
      dio: _dio,
      uri: Uri.http(
        Endpoints.authority,
        Endpoints.command,
      ),
      data: insertCompanyRequest.toJson(),
    );
    return response;
    final result = await action();
    return result;
  } catch (e) {
    rethrow;
  }
}*/
