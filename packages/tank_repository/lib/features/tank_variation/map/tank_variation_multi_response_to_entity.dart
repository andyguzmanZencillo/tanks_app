import 'package:tank_api/features/tank_variation/models/tank_variation_multi_response.dart';
import 'package:tank_repository/features/tank_variation/entity/tank_variation_multi_entity.dart';
import 'package:tank_repository/features/tank_variation/map/tank_variation_response_to_entity.dart';
import 'package:tank_repository/features/tanks/entity/tanks_entity.dart';

extension MapperTankVariationMultiResponseToEntity
    on TankVariationMultiResponse {
  TankVariationMultiEntity toEntity() {
    return TankVariationMultiEntity(
      tank: TanksEntity(
        idTanque: tank.idTanque,
        idCompania: tank.idCompania,
        idCentroVenta: tank.idCentroVenta,
        idArticulo: tank.idArticulo,
        capacidad: tank.capacidad,
        alturaTanque: tank.alturaTanque,
        descripcion: tank.descripcion,
        porcentajeMinimoCombustible: tank.porcentajeMinimoCombustible,
        alturaOffset: tank.alturaOffset,
        factorInicioDescargue: tank.factorInicioDescargue,
        codigo: tank.codigo,
        alturaAguaOffset: tank.alturaAguaOffset,
        offsetInclinacion: tank.offsetInclinacion,
        estado: tank.estado,
        modificable: tank.modificable,
        manejaMm: tank.manejaMm,
        idConsolaTanque: tank.idConsolaTanque,
      ),
      tankVariation: tankVariation.map((e) => e.toEntity()).toList(),
      tanksVariationLast: tanksVariationLast
          .map(
            (e) => TankVariationLastEntity(
              fechaZ: e.fechaZ,
              inventarioFinalCalculado: e.inventarioFinalCalculado,
              inventarioFinalFisico: e.inventarioFinalFisico,
              aguaFinal: e.aguaFinal,
              saldoFinal: e.saldoFinal,
              rn: e.rn,
            ),
          )
          .toList(),
    );
  }
}
