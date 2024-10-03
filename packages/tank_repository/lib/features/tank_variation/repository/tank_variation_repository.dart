/*import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_entity.dart';

class TankVariationRepository {
  TankVariationRepository({
    TankVariationApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? TankVariationApi();

  final TankVariationApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<TankVariationEntity>, Failure>> getAll() {
    return handleExceptionCompleteToken<List<TankVariationEntity>>(() async {
      final request = GetTankVariationRequest(
        idCompania: 1,
      );
      final response = await _api.getAll(request);
      return response
          .map(
            (e) => TankVariationEntity(
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

  Future<Result<bool, Failure>> saveTankVariation(
    TankVariationEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = InsertTankVariationRequest(
        idTanque: e.idTanque,
        idCompania: e.idCompania,
        alturaTanque: e.alturaTanque,
        volumen: e.volumen,
      );
      final response = await _api.save(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateTankVariation(
    TankVariationEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = UpdateTankVariationRequest(
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

  Future<Result<bool, Failure>> deleteTankVariation(int idTank) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = DeleteTankVariationRequest(
        idAforo: idTank,
        idCompania: 1,
      );
      final response = await _api.delete(request);
      return true;
    });
  }
}
*/