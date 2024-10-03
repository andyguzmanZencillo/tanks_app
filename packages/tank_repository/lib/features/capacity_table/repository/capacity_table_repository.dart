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

  Future<Result<List<CapacityTableEntity>, Failure>> getAll() {
    return handleExceptionCompleteToken<List<CapacityTableEntity>>(() async {
      final request = GetCapacityTableRequest(
        idCompania: 1,
      );
      final response = await _api.getAll(request);
      return response
          .map(
            (e) => CapacityTableEntity(
              idTanque: e.idTanque,
              idCompania: e.idCompania,
              idAforo: e.idAforo,
              alturaTanque: e.alturaTanque,
              volumen: e.volumen,
              idStaging: DateTime.now().millisecondsSinceEpoch,
            ),
          )
          .toList();
    });
  }

  Future<Result<List<CapacityTableEntity>, Failure>> getToTank({
    required int idTank,
  }) {
    return handleExceptionCompleteToken<List<CapacityTableEntity>>(() async {
      final request = GetCapacityTableToTankRequest(
        idCompania: 1,
        idTanque: idTank,
      );
      final response = await _api.getToTank(request);
      return response
          .map(
            (e) => CapacityTableEntity(
              idTanque: e.idTanque,
              idCompania: e.idCompania,
              idAforo: e.idAforo,
              alturaTanque: e.alturaTanque,
              volumen: e.volumen,
            ),
          )
          .toList();
    });
  }

  Future<Result<bool, Failure>> saveCapacityTable(
    CapacityTableEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = InsertCapacityTableRequest(
        idTanque: e.idTanque,
        idCompania: e.idCompania,
        alturaTanque: e.alturaTanque,
        volumen: e.volumen,
      );
      final response = await _api.save(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateCapacityTable(
    CapacityTableEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = UpdateCapacityTableRequest(
        idTanque: e.idTanque,
        idCompania: e.idCompania,
        idAforo: e.idAforo,
        alturaTanque: e.alturaTanque,
        volumen: e.volumen,
      );
      final response = await _api.update(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> deleteCapacityTable(int idTank) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = DeleteCapacityTableRequest(
        idAforo: idTank,
        idCompania: 1,
      );
      final response = await _api.delete(request);
      return true;
    });
  }
}
