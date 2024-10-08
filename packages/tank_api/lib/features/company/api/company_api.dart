import 'package:dio/dio.dart';
import 'package:failures/failures.dart';
import 'package:tank_api/core/models/default_response.dart';
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
      return response.message;
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
  Future<DataResponse> post(
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
      if (!response.result) throw ResultException(response.message);
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
