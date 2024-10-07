import 'package:tank_api/features/company/company.dart';

class BinnacleRequest extends RequestBase {
  BinnacleRequest({super.query = 'FNZSTanques_crud_consola_bitacora'});
}

class InsertBinnacleRequest extends BinnacleRequest {
  InsertBinnacleRequest({
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
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
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

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_tanque': idTanque,
      'id_centroventa': idCentroVenta,
      'descripcion': descripcion,
      'codigo_tanque': codigoTanque,
      'saldo': saldo,
      'agua': agua,
      'descargue': descargue,
      'saldo_altura': saldoAltura,
      'agua_altura': aguaAltura,
      'volumen_real': volumenReal,
      'fecha_lectura': fechaLectura,
      'hora': hora,
    });
  }
}

class UpdateBinnacleRequest extends BinnacleRequest {
  UpdateBinnacleRequest({
    required this.idCompania,
    required this.idBitacora,
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
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;
  final int idBitacora;

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

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_bitacora': idBitacora,
      'id_tanque': idTanque,
      'id_centroventa': idCentroVenta,
      'descripcion': descripcion,
      'codigo_tanque': codigoTanque,
      'saldo': saldo,
      'agua': agua,
      'descargue': descargue,
      'saldo_altura': saldoAltura,
      'agua_altura': aguaAltura,
      'volumen_real': volumenReal,
      'fecha_lectura': fechaLectura,
      'hora': hora,
    });
  }
}

class GetBinnacleRequest extends BinnacleRequest {
  GetBinnacleRequest({
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

class DeleteBinnacleRequest extends BinnacleRequest {
  DeleteBinnacleRequest({
    required this.idBinnacleuracion,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'D',
  });
  final int idUserTrace;
  final String operation;
  final int idBinnacleuracion;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_configuracion': idBinnacleuracion,
      'id_compania': idCompania,
    });
  }
}
