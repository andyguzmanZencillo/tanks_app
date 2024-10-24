import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/features.dart';

extension MapperTankVariationEntityToRequest on TankVariationEntity {
  UpdateTankVariationRequest toUpdateRequest() {
    return UpdateTankVariationRequest(
      idVariacion: idVariacion,
      idCompania: idCompania,
      idTanque: idTanque,
      fechaZ: fechaZ ?? DateTime.now(),
      saldoInicial: saldoInicial,
      comprasFacturas: comprasFacturas,
      descargue: descargue,
      venta: venta,
      calibracion: calibracion,
      inventarioFinalCalculado: inventarioFinalCalculado,
      inventarioFinalFisico: inventarioFinalFisico,
      variacionEnTransito: variacionEnTransito,
      variacionTransitoPorcentaje: variacionTransitoPorcentaje,
      variacionOperacional: variacionOperacional,
      variacionOperacionalPorcentaje: variacionOperacionalPorcentaje,
      variacionTotal: variacionTotal,
      variacionTotalPorcentaje: variacionTotalPorcentaje,
      aguaInicial: aguaInicial,
      aguaFinal: aguaFinal,
      saldoFinal: saldoFinal,
    );
  }
}
