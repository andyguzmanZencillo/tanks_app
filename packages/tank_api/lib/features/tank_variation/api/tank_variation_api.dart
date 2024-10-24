import 'package:failures/failures.dart';
import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/tank_variation/models/tank_variation_request.dart';
import 'package:tank_api/features/tank_variation/models/tank_variation_response.dart';

class TankVariationApi extends BaseApi {
  Future<bool> save(
    InsertTankVariationRequest insertTankVariationRequest,
  ) async {
    try {
      final response = await post(
        insertTankVariationRequest.toJson(),
      );
      if (!response.result) throw ResultException(response.message);
      return response.result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TankVariationResponse>> getAll(
    GetTankVariationRequest getTankVariationRequest,
  ) async {
    try {
      final response = await post(
        getTankVariationRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => TankVariationResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TankVariationResponse>> getToSaleCenter(
    GetTankVariationToSaleCenterRequest getTankVariationRequest,
  ) async {
    try {
      final response = await post(
        getTankVariationRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => TankVariationResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TankVariationResponse>> getToSaleCenterDate(
    GetTankVariationToSaleCenterDateRequest getTankVariationRequest,
  ) async {
    try {
      final response = await post(
        getTankVariationRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => TankVariationResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TankVariationResponse>> getToSaleCenterTankDate(
    GetTankVariationToSaleCenterTankDateRequest getTankVariationRequest,
  ) async {
    try {
      final response = await post(
        getTankVariationRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => TankVariationResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(
    DeleteTankVariationRequest deletehUserRequest,
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
    UpdateTankVariationRequest updateTankVariationRequest,
  ) async {
    try {
      final response = await post(
        updateTankVariationRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }
}
