import 'package:tank_api/features/company/company.dart';

class CapacityTableRequest extends RequestBase {
  CapacityTableRequest({super.query = 'FNZSTanques_crud_tabla_aforo'});
}

class InsertCapacityTableRequest extends CapacityTableRequest {
  InsertCapacityTableRequest({
    required this.idCompania,
    required this.idTanque,
    required this.alturaTanque,
    required this.volumen,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final int idTanque;
  final double alturaTanque;
  final double volumen;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_tanque': idTanque,
      'altura_tanque': alturaTanque,
      'volumen': volumen,
    });
  }
}

class UpdateCapacityTableRequest extends CapacityTableRequest {
  UpdateCapacityTableRequest({
    required this.idCompania,
    required this.idAforo,
    required this.idTanque,
    required this.alturaTanque,
    required this.volumen,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;
  final int idAforo;
  final int idTanque;
  final double alturaTanque;
  final double volumen;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_aforo': idAforo,
      'id_compania': idCompania,
      'id_tanque': idTanque,
      'altura_tanque': alturaTanque,
      'volumen': volumen,
    });
  }
}

class GetCapacityTableRequest extends CapacityTableRequest {
  GetCapacityTableRequest({
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

class GetCapacityTableToTankRequest extends CapacityTableRequest {
  GetCapacityTableToTankRequest({
    required this.idCompania,
    required this.idTanque,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;

  final int idCompania;
  final int idTanque;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_tanque': idTanque,
      'id_compania': idCompania,
    });
  }
}

class DeleteCapacityTableRequest extends CapacityTableRequest {
  DeleteCapacityTableRequest({
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
