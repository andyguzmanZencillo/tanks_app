import 'package:tank_api/core/extends/json_extends.dart';

class TankVariationLastResponse {
  TankVariationLastResponse({
    required this.fechaZ,
    required this.inventarioFinalCalculado,
    required this.inventarioFinalFisico,
    required this.aguaFinal,
    required this.saldoFinal,
    required this.rn,
  });

  factory TankVariationLastResponse.fromJson(Map<String, dynamic> json) {
    return TankVariationLastResponse(
      fechaZ: json.getPro('anterior_fecha_z', DateTime.now()),
      inventarioFinalCalculado: json.getPro('inventario_final_calculado', 0),
      inventarioFinalFisico: json.getPro('anterior_inventario_final_fisico', 0),
      aguaFinal: json.getPro('anterior_agua_final', 0),
      saldoFinal: json.getPro('anterior_saldo_final', 0),
      rn: json.getPro('rn', 0),
    );
  }

  final DateTime fechaZ;
  final double inventarioFinalCalculado;
  final double inventarioFinalFisico;

  final double aguaFinal;
  final double saldoFinal;
  final int rn;
}
