import 'package:tank_api/features/company/company.dart';

class ConfigRequest extends RequestBase {
  ConfigRequest({super.query = 'FNZSTanques_crud_configuracion'});
}

class InsertConfigRequest extends ConfigRequest {
  InsertConfigRequest({
    required this.idCompania,
    required this.horaInicioZeta,
    required this.horaFinZeta,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final String horaInicioZeta;
  final String horaFinZeta;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'hora_inicio_zeta': horaInicioZeta,
      'hora_fin_zeta': horaFinZeta,
    });
  }
}

class UpdateConfigRequest extends ConfigRequest {
  UpdateConfigRequest({
    required this.idCompania,
    required this.idConfiguracion,
    required this.horaInicioZeta,
    required this.horaFinZeta,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;

  final int idConfiguracion;
  final String horaInicioZeta;
  final String horaFinZeta;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_configuracion': idConfiguracion,
      'id_compania': idCompania,
      'hora_inicio_zeta': horaInicioZeta,
      'hora_fin_zeta': horaFinZeta,
    });
  }
}

class GetConfigRequest extends ConfigRequest {
  GetConfigRequest({
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

class DeleteConfigRequest extends ConfigRequest {
  DeleteConfigRequest({
    required this.idConfiguracion,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'D',
  });
  final int idUserTrace;
  final String operation;
  final int idConfiguracion;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_configuracion': idConfiguracion,
      'id_compania': idCompania,
    });
  }
}
