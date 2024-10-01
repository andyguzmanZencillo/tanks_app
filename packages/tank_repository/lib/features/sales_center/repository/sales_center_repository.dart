import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';

class SalesCenterRepository {
  SalesCenterRepository({
    SalesCenterApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? SalesCenterApi();

  final SalesCenterApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<SalesCenterEntity>, Failure>> getAll() {
    return handleExceptionCompleteToken<List<SalesCenterEntity>>(() async {
      //final user = await _userDatabase.getUser();
      final request = GetSalesCenterRequest(
        idCompania: 1,
      );
      final response = await _api.getAll(request);
      return response
          .map(
            (e) => SalesCenterEntity(
              idCentroVenta: e.idCentroVenta,
              idCompania: e.idCompania,
              centroVenta: e.centroVenta,
              descripcion: e.descripcion,
              correo: e.correo,
            ),
          )
          .toList();
    });
  }

  Future<Result<bool, Failure>> saveSalesCenter(
    SalesCenterEntity salesCenterEntity,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = InsertSalesCenterRequest(
        idCompania: 1,
        salesCenter: salesCenterEntity.centroVenta,
        description: salesCenterEntity.descripcion,
        email: salesCenterEntity.correo,
      );
      final response = await _api.save(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateSalesCenter(
    SalesCenterEntity salesCenterEntity,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = UpdateSalesCenterRequest(
        idCompania: 1,
        idSaleCenter: salesCenterEntity.idCentroVenta,
        salesCenter: salesCenterEntity.centroVenta,
        description: salesCenterEntity.descripcion,
        email: salesCenterEntity.correo,
      );
      final response = await _api.update(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> deleteSalesCenter(int idSalesCenter) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = DeleteSalesCenterRequest(
        idSalesCenter: idSalesCenter,
        idCompania: 1,
      );
      final response = await _api.delete(request);
      return true;
    });
  }
}
