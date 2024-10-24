import 'package:tank_api/features/company/models/company_request.dart';

class NotificationMultiRequest extends RequestBase {
  NotificationMultiRequest({
    super.query = 'FNZSTanques_multi_table_crud',
  });
}

class InserNotificationMultiRequest extends NotificationMultiRequest {
  InserNotificationMultiRequest({
    required this.idCompania,
    required this.idUsuario,
    required this.idAlerta,
    required this.idNotificacion,
    this.idUserTrace = 123,
    this.operation = 'I_UsuarioAlertaNotif',
  });

  final int idUserTrace;
  final String operation;

  final int idUsuario;
  final List<int> idAlerta;
  final List<int> idNotificacion;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_usuario': idUsuario,
      'id_alerta': idAlerta,
      'id_notification': idNotificacion,
      'id_compania': idCompania,
    });
  }
}
