import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_entity.dart';
import 'package:tank_repository/features/tank_variation/map/tank_variation_entity_to_insert_request.dart';
import 'package:tank_repository/features/tank_variation/map/tank_variation_entity_to_update_request.dart';
import 'package:tank_repository/features/tank_variation/map/tank_variation_response_to_entity.dart';

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
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<List<TankVariationEntity>, Failure>> getToSaleCenter({
    required int idCentroVenta,
    required DateTime date,
  }) {
    return handleExceptionCompleteToken<List<TankVariationEntity>>(() async {
      final request = GetTankVariationToSaleCenterRequest(
        idCompania: 1,
        idCentroVenta: idCentroVenta,
        date: date,
      );
      final response = await _api.getToSaleCenter(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<List<TankVariationEntity>, Failure>> getToSaleCenterDate({
    required int idCentroVenta,
    required DateTime dateInit,
    required DateTime dateFinal,
  }) {
    return handleExceptionCompleteToken<List<TankVariationEntity>>(() async {
      final request = GetTankVariationToSaleCenterDateRequest(
        idCompania: 1,
        idCentroVenta: idCentroVenta,
        dateInit: dateInit,
        dateFinal: dateFinal,
      );
      final response = await _api.getToSaleCenterDate(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<List<TankVariationEntity>, Failure>> getToSaleCenterTankDate({
    required int idCentroVenta,
    required int idTanque,
    required DateTime dateInit,
    required DateTime dateFinal,
  }) {
    return handleExceptionCompleteToken<List<TankVariationEntity>>(() async {
      final request = GetTankVariationToSaleCenterTankDateRequest(
        idCompania: 1,
        idTanque: idTanque,
        idCentroVenta: idCentroVenta,
        dateInit: dateInit,
        dateFinal: dateFinal,
      );
      final response = await _api.getToSaleCenterTankDate(request);
      return response
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    });
  }

  Future<Result<bool, Failure>> saveTankVariation(
    TankVariationEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = e.toInsertRequest();
      final response = await _api.save(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateTankVariation(
    TankVariationEntity e,
  ) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = e.toUpdateRequest();
      final response = await _api.update(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> deleteTankVariation(int idTank) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = DeleteTankVariationRequest(
        idVariacion: idTank,
        idCompania: 1,
      );
      final response = await _api.delete(request);
      return true;
    });
  }
}
