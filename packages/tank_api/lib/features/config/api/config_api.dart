import 'package:failures/failures.dart';
import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/config/models/config_request.dart';
import 'package:tank_api/features/config/models/config_response.dart';

class ConfigApi extends BaseApi {
  Future<bool> save(
    InsertConfigRequest insertConfigRequest,
  ) async {
    try {
      final response = await post(
        insertConfigRequest.toJson(),
      );
      if (!response.result) throw ResultException(response.message);
      return response.result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ConfigResponse>> getAll(
    GetConfigRequest getConfigRequest,
  ) async {
    try {
      final response = await post(
        getConfigRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => ConfigResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(
    DeleteConfigRequest deletehUserRequest,
  ) async {
    try {
      final response = await post(
        deletehUserRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> update(
    UpdateConfigRequest updateConfigRequest,
  ) async {
    try {
      final response = await post(
        updateConfigRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }
}
