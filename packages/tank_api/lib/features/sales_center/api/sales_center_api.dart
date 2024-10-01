import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/sales_center/models/sales_center_request.dart';
import 'package:tank_api/features/sales_center/models/sales_center_response.dart';

class SalesCenterApi extends BaseApi {
  Future<String> save(
    InsertSalesCenterRequest insertSalesCenterRequest,
  ) async {
    try {
      final response = await post(
        insertSalesCenterRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SalesCenterResponse>> getAll(
    GetSalesCenterRequest getSalesCenterRequest,
  ) async {
    try {
      final response = await post(
        getSalesCenterRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => SalesCenterResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(
    DeleteSalesCenterRequest deletehUserRequest,
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
    UpdateSalesCenterRequest updateSalesCenterRequest,
  ) async {
    try {
      final response = await post(
        updateSalesCenterRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }
}
