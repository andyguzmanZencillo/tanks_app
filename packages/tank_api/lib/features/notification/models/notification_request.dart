import 'package:tank_api/features/company/models/company_request.dart';

class NotificationRequest extends RequestBase {
  NotificationRequest({
    super.query = 'FNZSTanques_crud_notificacion',
  });
}

class GetNotificationRequest extends NotificationRequest {
  GetNotificationRequest({
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
