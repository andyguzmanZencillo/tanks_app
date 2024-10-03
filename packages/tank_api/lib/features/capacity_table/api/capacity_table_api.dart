import 'package:failures/failures.dart';
import 'package:tank_api/features/capacity_table/models/capacity_table_request.dart';
import 'package:tank_api/features/capacity_table/models/capacity_table_response.dart';
import 'package:tank_api/features/company/api/company_api.dart';

class CapacityTableApi extends BaseApi {
  Future<bool> save(
    InsertCapacityTableRequest insertCapacityTableRequest,
  ) async {
    try {
      final response = await post(
        insertCapacityTableRequest.toJson(),
      );
      if (!response.result) throw ResultException(response.message);
      return response.result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CapacityTableResponse>> getAll(
    GetCapacityTableRequest getCapacityTableRequest,
  ) async {
    try {
      final response = await post(
        getCapacityTableRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => CapacityTableResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CapacityTableResponse>> getToTank(
    GetCapacityTableToTankRequest getCapacityTableToTankRequest,
  ) async {
    try {
      final response = await post(
        getCapacityTableToTankRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => CapacityTableResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(
    DeleteCapacityTableRequest deletehUserRequest,
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
    UpdateCapacityTableRequest updateCapacityTableRequest,
  ) async {
    try {
      final response = await post(
        updateCapacityTableRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }
}
