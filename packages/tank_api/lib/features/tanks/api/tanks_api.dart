import 'package:failures/failures.dart';
import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/tanks/models/tanks_request.dart';
import 'package:tank_api/features/tanks/models/tanks_response.dart';

class TanksApi extends BaseApi {
  Future<bool> save(
    InsertTanksRequest insertTanksRequest,
  ) async {
    try {
      final response = await post(
        insertTanksRequest.toJson(),
      );
      if (!response.result) throw ResultException(response.message);
      return response.result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TanksResponse>> getAll(
    GetTanksRequest getTanksRequest,
  ) async {
    try {
      final response = await post(
        getTanksRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => TanksResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(
    DeleteTanksRequest deletehUserRequest,
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
    UpdateTanksRequest updateTanksRequest,
  ) async {
    try {
      final response = await post(
        updateTanksRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }
}
