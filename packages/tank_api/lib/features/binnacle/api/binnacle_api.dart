import 'package:tank_api/features/binnacle/models/binnacle_request.dart';
import 'package:tank_api/features/binnacle/models/binnacle_response.dart';
import 'package:tank_api/features/company/api/company_api.dart';

class BinnacleApi extends BaseApi {
  Future<List<BinnacleResponse>> getAll(
    GetBinnacleRequest getBinnacleRequest,
  ) async {
    try {
      final response = await post(
        getBinnacleRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => BinnacleResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
