import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/capacity_table/entity/capacity_table_entity.dart';

class CapacityTableRepository {
  CapacityTableRepository({
    CapacityTableApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? CapacityTableApi();

  final CapacityTableApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<CapacityEntity>, Failure>> getToTank({
    required int idTank,
  }) {
    return handleExceptionCompleteToken<List<CapacityEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetCapacityTableToTankRequest(
        idCompania: user.idCompany,
        idTanque: idTank,
      );
      final response = await _api.getToTank(request);

      return response
          .map(
            (e) => CapacityEntity(
              idAforo: e.idAforo,
              alturaTanque: e.alturaTanque,
              volumen: e.volumen,
              idStaging: '0',
            ),
          )
          .toList();
    });
  }

  Future<Result<bool, Failure>> saveCapacityTable(
    CapacityTableEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = InsertCapacityTableRequest(
        idTanque: e.idTanque,
        idCompania: user.idCompany,
        data: e.data
            .map(
              (e) => CapacityRequest(
                alturaTanque: e.alturaTanque,
                volumen: e.volumen,
              ),
            )
            .toList(),
      );
      await _api.save(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> deleteCapacityTable(int idTank) {
    return handleExceptionCompleteToken<bool>(() async {
      final user = await _userDatabase.getUser();
      final request = DeleteCapacityTableRequest(
        idAforo: idTank,
        idCompania: user.idCompany,
      );
      await _api.delete(request);
      return true;
    });
  }
}
