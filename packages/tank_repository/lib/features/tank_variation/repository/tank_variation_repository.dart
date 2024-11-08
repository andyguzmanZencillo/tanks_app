import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_entity.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_multi_entity.dart';
import 'package:tank_repository/features/tank_variation/map/tank_variation_entity_to_insert_request.dart';
import 'package:tank_repository/features/tank_variation/map/tank_variation_entity_to_update_request.dart';
import 'package:tank_repository/features/tank_variation/map/tank_variation_multi_response_to_entity.dart';
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
      final user = await _userDatabase.getUser();
      final request = GetTankVariationRequest(
        idCompania: user.idCompany,
      );
      final response = await _api.getAll(request);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  Future<Result<List<TankVariationEntity>, Failure>> getBySaleCenterAndDate({
    required int idCentroVenta,
    required DateTime date,
  }) {
    return handleExceptionCompleteToken<List<TankVariationEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetTankVariationToSaleCenterRequest(
        idCompania: user.idCompany,
        idCentroVenta: idCentroVenta,
        date: date,
      );
      final response = await _api.getBySaleCenterAndDate(request);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  Future<Result<List<TankVariationMultiEntity>, Failure>>
      getBySaleCenterAndDatePro({
    required int idCentroVenta,
    required DateTime date,
  }) {
    return handleExceptionCompleteToken<List<TankVariationMultiEntity>>(
        () async {
      final user = await _userDatabase.getUser();
      final request = GetTankVariationBySaleCenterAndDate(
        idCompania: user.idCompany,
        idCentroVenta: idCentroVenta,
        date: date,
      );
      final response = await _api.getBySaleCenterAndDatePro(request);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  Future<Result<List<TankVariationEntity>, Failure>>
      getBySaleCenterAndRangeDate({
    required int idCentroVenta,
    required DateTime dateInit,
    required DateTime dateFinal,
  }) {
    return handleExceptionCompleteToken<List<TankVariationEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetTankVariationToSaleCenterDateRequest(
        idCompania: user.idCompany,
        idCentroVenta: idCentroVenta,
        dateInit: dateInit,
        dateFinal: dateFinal,
      );
      final response = await _api.getBySaleCenterAndRangeDate(request);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  Future<Result<List<TankVariationEntity>, Failure>>
      getBySaleCenterAndTankAndDate({
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
      final response = await _api.getBySaleCenterAndTankAndDate(request);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  Future<Result<List<TankVariationEntity>, Failure>> getByTank({
    required int idTanque,
  }) {
    return handleExceptionCompleteToken<List<TankVariationEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetTankVariationByTankRequest(
        idCompania: user.idCompany,
        idTanque: idTanque,
      );
      final response = await _api.getByTank(request);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  Future<Result<Unit, Failure>> save(
    TankVariationEntity e,
  ) {
    return handleExceptionCompleteToken<Unit>(() async {
      final user = await _userDatabase.getUser();

      final request = e
          .copyWith(
            idCompania: user.idCompany,
          )
          .toInsertRequest();
      await _api.save(request);
      return unit;
    });
  }

  Future<Result<Unit, Failure>> updateTankVariation(
    TankVariationEntity e,
  ) {
    return handleExceptionCompleteToken<Unit>(() async {
      final request = e.toUpdateRequest();
      await _api.update(request);
      return unit;
    });
  }

  Future<Result<Unit, Failure>> deleteTankVariation(int idTank) {
    return handleExceptionCompleteToken<Unit>(() async {
      final user = await _userDatabase.getUser();
      final request = DeleteTankVariationRequest(
        idVariacion: idTank,
        idCompania: user.idCompany,
      );
      await _api.delete(request);
      return unit;
    });
  }
}
