import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/user_device/entity/user_notification_entity.dart';

extension MapperUserNotificationResponseToEntity on UserNotificationResponse {
  UserNotificationEntity toEntity() {
    return UserNotificationEntity(
      idUsuario: idUsuario,
      idCompania: idCompania,
      idNotificacion: idNotificacion,
      idUsuarioNotificacion: idUsuarioNotificacion,
    );
  }
}
