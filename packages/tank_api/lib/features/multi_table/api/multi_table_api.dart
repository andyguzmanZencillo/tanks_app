import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/multi_table/models/multi_table_response.dart';
import 'package:tank_api/features/multi_table/multi_table.dart';

class MultiTableApi extends BaseApi {
  Future<MultiTableResponse> getCentroArticuloConsola(
    GetCentroVentaArticuloConsolaRequest request,
  ) async {
    try {
      final response = await post(
        request.toJson(),
      );
      final map = response.resultSp as Map<String, dynamic>;
      return MultiTableResponse.fromJson(map);
    } catch (e) {
      rethrow;
    }
  }
}
