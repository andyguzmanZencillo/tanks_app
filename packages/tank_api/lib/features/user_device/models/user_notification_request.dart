import 'package:tank_api/features/company/models/company_request.dart';

class UserNotificationRequest extends RequestBase {
  UserNotificationRequest({
    super.query = 'FNZSTanques_crud_usuario_notificacion',
  });
}

class InsertUserNotificationRequest extends UserNotificationRequest {
  InsertUserNotificationRequest({
    required this.idCompania,
    required this.idUsuario,
    required this.idNotificacion,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;

  final int idUsuario;
  final List<int> idNotificacion;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_notificacion': idNotificacion,
      'id_compania': idCompania,
    });
  }
}

class UpdateUserNotificationRequest extends UserNotificationRequest {
  UpdateUserNotificationRequest({
    required this.idCompania,
    required this.idUsuario,
    required this.idNotificacion,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final String operation;

  final int idUsuario;
  final List<int> idNotificacion;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_notificacion': idNotificacion,
      'id_compania': idCompania,
    });
  }
}

class GetUserNotificationRequest extends UserNotificationRequest {
  GetUserNotificationRequest({
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
