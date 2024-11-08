import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/tanks/entity/tanks_entity.dart';

class TanksRepository {
  TanksRepository({
    TanksApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? TanksApi();

  final TanksApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<TanksEntity>, Failure>> getAll() {
    return handleExceptionCompleteToken<List<TanksEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetTanksRequest(
        idCompania: user.idCompany,
      );
      final response = await _api.getAll(request);
      return response
          .map(
            (e) => TanksEntity(
              idTanque: e.idTanque,
              idCompania: e.idCompania,
              idCentroVenta: e.idCentroVenta,
              idArticulo: e.idArticulo,
              capacidad: e.capacidad,
              alturaTanque: e.alturaTanque,
              descripcion: e.descripcion,
              porcentajeMinimoCombustible: e.porcentajeMinimoCombustible,
              alturaOffset: e.alturaOffset,
              factorInicioDescargue: e.factorInicioDescargue,
              codigo: e.codigo,
              alturaAguaOffset: e.alturaAguaOffset,
              offsetInclinacion: e.offsetInclinacion,
              estado: e.estado,
              modificable: e.modificable,
              manejaMm: e.manejaMm,
              idConsolaTanque: e.idConsolaTanque,
            ),
          )
          .toList();
    });
  }

  Future<Result<List<TanksEntity>, Failure>> getToSaleCenter(int idSaleCenter) {
    return handleExceptionCompleteToken<List<TanksEntity>>(() async {
      final user = await _userDatabase.getUser();
      final request = GetTanksToSaleCenterRequest(
        idCompania: user.idCompany,
        idCentroVenta: idSaleCenter,
      );
      final response = await _api.getToSaleCenter(request);
      return response
          .map(
            (e) => TanksEntity(
              idTanque: e.idTanque,
              idCompania: e.idCompania,
              idCentroVenta: e.idCentroVenta,
              idArticulo: e.idArticulo,
              capacidad: e.capacidad,
              alturaTanque: e.alturaTanque,
              descripcion: e.descripcion,
              porcentajeMinimoCombustible: e.porcentajeMinimoCombustible,
              alturaOffset: e.alturaOffset,
              factorInicioDescargue: e.factorInicioDescargue,
              codigo: e.codigo,
              alturaAguaOffset: e.alturaAguaOffset,
              offsetInclinacion: e.offsetInclinacion,
              estado: e.estado,
              modificable: e.modificable,
              manejaMm: e.manejaMm,
              idConsolaTanque: e.idConsolaTanque,
            ),
          )
          .toList();
    });
  }

  Future<Result<Unit, Failure>> saveTanks(
    TanksEntity tanksEntity,
  ) {
    return handleExceptionCompleteToken<Unit>(() async {
      final user = await _userDatabase.getUser();
      final request = InsertTanksRequest(
        idCompania: user.idCompany,
        idCentroVenta: tanksEntity.idCentroVenta,
        idArticulo: tanksEntity.idArticulo,
        idConsolaTanque: tanksEntity.idConsolaTanque,
        capacidad: tanksEntity.capacidad,
        alturaTanque: tanksEntity.alturaTanque,
        descripcion: tanksEntity.descripcion,
        porcentajeMinimoCombustible: tanksEntity.porcentajeMinimoCombustible,
        alturaOffset: tanksEntity.alturaOffset,
        factorInicioDescargue: tanksEntity.factorInicioDescargue,
        codigo: tanksEntity.codigo,
        alturaAguaOffset: tanksEntity.alturaAguaOffset,
        offsetInclinacion: tanksEntity.offsetInclinacion,
        estado: tanksEntity.estado,
        modificable: tanksEntity.modificable,
        manejaMm: tanksEntity.manejaMm,
      );
      await _api.save(request);
      return unit;
    });
  }

  Future<Result<Unit, Failure>> updateTanks(
    TanksEntity tanksEntity,
  ) {
    return handleExceptionCompleteToken<Unit>(() async {
      final user = await _userDatabase.getUser();
      final request = UpdateTanksRequest(
        idTank: tanksEntity.idTanque,
        idCompania: user.idCompany,
        idCentroVenta: tanksEntity.idCentroVenta,
        idArticulo: tanksEntity.idArticulo,
        idConsolaTanque: tanksEntity.idConsolaTanque,
        capacidad: tanksEntity.capacidad,
        alturaTanque: tanksEntity.alturaTanque,
        descripcion: tanksEntity.descripcion,
        porcentajeMinimoCombustible: tanksEntity.porcentajeMinimoCombustible,
        alturaOffset: tanksEntity.alturaOffset,
        factorInicioDescargue: tanksEntity.factorInicioDescargue,
        codigo: tanksEntity.codigo,
        alturaAguaOffset: tanksEntity.alturaAguaOffset,
        offsetInclinacion: tanksEntity.offsetInclinacion,
        estado: tanksEntity.estado,
        modificable: tanksEntity.modificable,
        manejaMm: tanksEntity.manejaMm,
      );
      await _api.update(request);
      return unit;
    });
  }

  Future<Result<Unit, Failure>> deleteTanks(int idTank) {
    return handleExceptionCompleteToken<Unit>(() async {
      final user = await _userDatabase.getUser();
      final request = DeleteTanksRequest(
        idTank: idTank,
        idCompania: user.idCompany,
      );
      await _api.delete(request);
      return unit;
    });
  }
}
