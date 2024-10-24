import 'package:tank_api/features/company/models/company_request.dart';

class UserAlertRequest extends RequestBase {
  UserAlertRequest({
    super.query = 'FNZSTanques_crud_usuario_alerta',
  });
}

class InsertUserAlertRequest extends UserAlertRequest {
  InsertUserAlertRequest({
    required this.idCompania,
    required this.idUsuario,
    required this.idAlerta,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;

  final int idUsuario;
  final List<int> idAlerta;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_alerta': idAlerta,
      'id_compania': idCompania,
    });
  }
}

class UpdateUserAlertRequest extends UserAlertRequest {
  UpdateUserAlertRequest({
    required this.idCompania,
    required this.idUsuario,
    required this.idAlerta,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;

  final int idUsuario;
  final List<int> idAlerta;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_alerta': idAlerta,
      'id_compania': idCompania,
    });
  }
}

class GetUserAlertRequest extends UserAlertRequest {
  GetUserAlertRequest({
    required this.idCompania,
    required this.idUsuario,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;

  final int idCompania;
  final int idUsuario;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_usuario': idUsuario,
    });
  }
}
