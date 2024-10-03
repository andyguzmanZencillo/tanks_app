import 'package:tank_api/features/company/company.dart';

class TankVariationRequest extends RequestBase {
  TankVariationRequest({super.query = 'FNZSTanques_crud_variacion_tanque'});
}

class InsertTankVariationRequest extends TankVariationRequest {
  InsertTankVariationRequest({
    required this.idCompania,
    required this.idTanque,
    required this.fechaZ,
    required this.saldoInicial,
    required this.comprasFacturas,
    required this.descargue,
    required this.venta,
    required this.calibracion,
    required this.inventarioFinalCalculado,
    required this.inventarioFinalFisico,
    required this.variacionEnTransito,
    required this.variacionTransitoPorcentaje,
    required this.variacionOperacional,
    required this.variacionOperacionalPorcentaje,
    required this.variacionTotal,
    required this.variacionTotalPorcentaje,
    required this.aguaInicial,
    required this.aguaFinal,
    required this.saldoFinal,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final int idTanque;
  final String fechaZ;
  final double saldoInicial;
  final double comprasFacturas;
  final double descargue;
  final double venta;
  final double calibracion;
  final double inventarioFinalCalculado;
  final double inventarioFinalFisico;
  final double variacionEnTransito;
  final String variacionTransitoPorcentaje;
  final double variacionOperacional;
  final String variacionOperacionalPorcentaje;
  final double variacionTotal;
  final String variacionTotalPorcentaje;
  final double aguaInicial;
  final double aguaFinal;
  final double saldoFinal;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_tanque': idTanque,
      'fecha_z': fechaZ,
      'saldo_inicial': saldoInicial,
      'compras_facturas': comprasFacturas,
      'descargue': descargue,
      'venta': venta,
      'calibracion': calibracion,
      'inventario_final_calculado': inventarioFinalCalculado,
      'inventario_final_fisico': inventarioFinalFisico,
      'variacion_en_transito': variacionEnTransito,
      'variacion_transito_porcentaje': variacionTransitoPorcentaje,
      'variacion_operacional': variacionOperacional,
      'variacion_operacional_porcentaje': variacionOperacionalPorcentaje,
      'variacion_total': variacionTotal,
      'variacion_total_porcentaje': variacionTotalPorcentaje,
      'agua_inicial': aguaInicial,
      'agua_final': aguaFinal,
      'saldo_final': saldoFinal,
    });
  }
}

class UpdateTankVariationRequest extends TankVariationRequest {
  UpdateTankVariationRequest({
    required this.idVariacion,
    required this.idCompania,
    required this.idTanque,
    required this.fechaZ,
    required this.saldoInicial,
    required this.comprasFacturas,
    required this.descargue,
    required this.venta,
    required this.calibracion,
    required this.inventarioFinalCalculado,
    required this.inventarioFinalFisico,
    required this.variacionEnTransito,
    required this.variacionTransitoPorcentaje,
    required this.variacionOperacional,
    required this.variacionOperacionalPorcentaje,
    required this.variacionTotal,
    required this.variacionTotalPorcentaje,
    required this.aguaInicial,
    required this.aguaFinal,
    required this.saldoFinal,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final int idVariacion;
  final int idTanque;
  final String fechaZ;
  final double saldoInicial;
  final double comprasFacturas;
  final double descargue;
  final double venta;
  final double calibracion;
  final double inventarioFinalCalculado;
  final double inventarioFinalFisico;
  final double variacionEnTransito;
  final String variacionTransitoPorcentaje;
  final double variacionOperacional;
  final String variacionOperacionalPorcentaje;
  final double variacionTotal;
  final String variacionTotalPorcentaje;
  final double aguaInicial;
  final double aguaFinal;
  final double saldoFinal;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_variacion': idVariacion,
      'id_compania': idCompania,
      'id_tanque': idTanque,
      'fecha_z': fechaZ,
      'saldo_inicial': saldoInicial,
      'compras_facturas': comprasFacturas,
      'descargue': descargue,
      'venta': venta,
      'calibracion': calibracion,
      'inventario_final_calculado': inventarioFinalCalculado,
      'inventario_final_fisico': inventarioFinalFisico,
      'variacion_en_transito': variacionEnTransito,
      'variacion_transito_porcentaje': variacionTransitoPorcentaje,
      'variacion_operacional': variacionOperacional,
      'variacion_operacional_porcentaje': variacionOperacionalPorcentaje,
      'variacion_total': variacionTotal,
      'variacion_total_porcentaje': variacionTotalPorcentaje,
      'agua_inicial': aguaInicial,
      'agua_final': aguaFinal,
      'saldo_final': saldoFinal,
    });
  }
}

class GetTankVariationRequest extends TankVariationRequest {
  GetTankVariationRequest({
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;

  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
    });
  }
}

class DeleteTankVariationRequest extends TankVariationRequest {
  DeleteTankVariationRequest({
    required this.idAforo,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'D',
  });
  final int idUserTrace;
  final String operation;
  final int idAforo;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_aforo': idAforo,
      'id_compania': idCompania,
    });
  }
}
