import 'package:tank_api/core/extends/json_extends.dart';

class TanksResponse {
  TanksResponse({
    required this.idTanque,
    required this.idCompania,
    required this.idCentroVenta,
    required this.idArticulo,
    required this.capacidad,
    required this.alturaTanque,
    required this.descripcion,
    required this.porcentajeMinimoCombustible,
    required this.alturaOffset,
    required this.factorInicioDescargue,
    required this.codigo,
    required this.alturaAguaOffset,
    required this.offsetInclinacion,
    required this.estado,
    required this.modificable,
    required this.manejaMm,
    required this.idConsolaTanque,
  });

  factory TanksResponse.fromJson(Map<String, dynamic> json) {
    return TanksResponse(
      idTanque: json.get('id_tanque', 0),
      idCompania: json.get('id_compania', 0),
      idCentroVenta: json.get('id_centro_venta', 0),
      idArticulo: json.get('id_articulo', 0),
      idConsolaTanque: json.get('id_consola_tanque', 0),
      capacidad: json.get('capacidad', 0),
      alturaTanque: json.get('altura_tanque', 0),
      descripcion: json.get('descripcion', ''),
      porcentajeMinimoCombustible: json.get('porcentaje_minimo_combustible', 0),
      alturaOffset: json.get('altura_offset', 0),
      factorInicioDescargue: json.get('factor_inicio_descargue', 0),
      codigo: json.get('codigo', 0),
      alturaAguaOffset: json.get('altura_agua_offset', 0),
      offsetInclinacion: json.get('offset_inclinacion', 0),
      estado: json.get('estado', false),
      modificable: json.get('modificable', false),
      manejaMm: json.get('maneja_mm', false),
    );
  }
  final int idTanque;
  final int idCompania;
  final int idCentroVenta;
  final int idArticulo;
  final int idConsolaTanque;
  final double capacidad;
  final double alturaTanque;
  final String descripcion;
  final double porcentajeMinimoCombustible;
  final double alturaOffset;
  final double factorInicioDescargue;
  final int codigo;
  final double alturaAguaOffset;
  final double offsetInclinacion;
  final bool estado;
  final bool modificable;
  final bool manejaMm;
}
