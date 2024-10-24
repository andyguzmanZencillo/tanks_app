import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/notification/entity/notification_entity.dart';

extension MapperNotificationResponseToEntity on NotificationResponse {
  NotificationEntity toEntity() {
    return NotificationEntity(
      descripcion: descripcion,
      idCompania: idCompania,
      idNotificacion: idNotificacion,
      nombreNotificacion: nombreNotificacion,
    );
  }
}
