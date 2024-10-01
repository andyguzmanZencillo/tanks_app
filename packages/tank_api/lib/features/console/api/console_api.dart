import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/console/models/console_request.dart';
import 'package:tank_api/features/console/models/console_response.dart';

class ConsoleApi extends BaseApi {
  Future<String> save(
    InsertConsoleRequest insertConsoleRequest,
  ) async {
    try {
      final response = await post(
        insertConsoleRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ConsoleResponse>> getAll(
    GetConsoleRequest getConsoleRequest,
  ) async {
    try {
      final response = await post(
        getConsoleRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => ConsoleResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(
    DeleteConsoleRequest deletehUserRequest,
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
    UpdateConsoleRequest updateConsoleRequest,
  ) async {
    try {
      final response = await post(
        updateConsoleRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }
}
