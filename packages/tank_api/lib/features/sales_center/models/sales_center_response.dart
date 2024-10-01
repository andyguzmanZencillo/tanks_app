import 'package:tank_api/core/extends/json_extends.dart';

class SalesCenterResponse {
  SalesCenterResponse({
    required this.idCentroVenta,
    required this.idCompania,
    required this.centroVenta,
    required this.descripcion,
    required this.correo,
  });
  factory SalesCenterResponse.fromJson(Map<String, dynamic> json) {
    return SalesCenterResponse(
      idCentroVenta: json.get('id_centro_venta', 0),
      idCompania: json.get('id_compania', 0),
      centroVenta: json.get('centro_venta', ''),
      descripcion: json.get('descripcion', ''),
      correo: json.get('correo', ''),
    );
  }
  final int idCentroVenta;
  final int idCompania;
  final String centroVenta;
  final String descripcion;
  final String correo;
}
