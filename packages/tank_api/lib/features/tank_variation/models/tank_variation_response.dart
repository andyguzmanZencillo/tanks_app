import 'package:tank_api/core/extends/json_extends.dart';

class TankVariationResponse {
  TankVariationResponse({
    required this.idVariacion,
    required this.idUserTrace,
    required this.operation,
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
  });

  factory TankVariationResponse.fromJson(Map<String, dynamic> json) {
    return TankVariationResponse(
      idVariacion: json.get('id_variacion', 0),
      idUserTrace: json.get('id_user_trace', 0),
      operation: json.get('operation', ''),
      idCompania: json.get('id_compania', 0),
      idTanque: json.get('id_tanque', 0),
      fechaZ: json.get('fecha_z', ''),
      saldoInicial: json.get('saldo_inicial', 0),
      comprasFacturas: json.get('compras_facturas', 0),
      descargue: json.get('descargue', 0),
      venta: json.get('venta', 0),
      calibracion: json.get('calibracion', 0),
      inventarioFinalCalculado: json.get('inventario_final_calculado', 0),
      inventarioFinalFisico: json.get('inventario_final_fisico', 0),
      variacionEnTransito: json.get('variacion_en_transito', 0),
      variacionTransitoPorcentaje:
          json.get('variacion_transito_porcentaje', '0%'),
      variacionOperacional: json.get('variacion_operacional', 0),
      variacionOperacionalPorcentaje:
          json.get('variacion_operacional_porcentaje', '0%'),
      variacionTotal: json.get('variacion_total', 0),
      variacionTotalPorcentaje: json.get('variacion_total_porcentaje', '0%'),
      aguaInicial: json.get('agua_inicial', 0),
      aguaFinal: json.get('agua_final', 0),
      saldoFinal: json.get('saldo_final', 0),
    );
  }

  final int idVariacion;
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
}
