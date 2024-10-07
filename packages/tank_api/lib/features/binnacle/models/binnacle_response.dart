import 'package:tank_api/core/extends/json_extends.dart';

class BinnacleResponse {
  BinnacleResponse({
    required this.idBitacora,
    required this.idCompania,
    required this.idTanque,
    required this.idCentroVenta,
    required this.descripcion,
    required this.codigoTanque,
    required this.saldo,
    required this.agua,
    required this.descargue,
    required this.saldoAltura,
    required this.aguaAltura,
    required this.volumenReal,
    required this.fechaLectura,
    required this.hora,
  });

  factory BinnacleResponse.fromJson(Map<String, dynamic> json) {
    return BinnacleResponse(
      idBitacora: json.get('id_bitacora', 0),
      idCompania: json.get('id_compania', 0),
      idTanque: json.get('id_tanque', 0),
      idCentroVenta: json.get('id_centroventa', 0),
      descripcion: json.get('descripcion', ''),
      codigoTanque: json.get('codigo_tanque', ''),
      saldo: json.get('saldo', 0),
      agua: json.get('agua', 0),
      descargue: json.get('descargue', 0),
      saldoAltura: json.get('saldo_altura', 0),
      aguaAltura: json.get('agua_altura', 0),
      volumenReal: json.get('volumen_real', 0),
      fechaLectura: json.get('fecha_lectura', ''),
      hora: json.get('hora', ''),
    );
  }

  final int idBitacora;
  final int idCompania;
  final int idTanque;
  final int idCentroVenta;
  final String descripcion;
  final String codigoTanque;
  final double saldo;
  final double agua;
  final double descargue;
  final double saldoAltura;
  final double aguaAltura;
  final double volumenReal;
  final String fechaLectura;
  final String hora;
}
