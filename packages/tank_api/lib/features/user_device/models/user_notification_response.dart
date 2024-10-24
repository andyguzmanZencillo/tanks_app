import 'package:tank_api/core/extends/json_extends.dart';

class UserNotificationResponse {
  UserNotificationResponse({
    required this.idUsuario,
    required this.idCompania,
    required this.idNotificacion,
    required this.idUsuarioNotificacion,
  });

  factory UserNotificationResponse.fromJson(Map<String, dynamic> json) {
    return UserNotificationResponse(
      idUsuario: json.get('id_usuario', 0),
      idCompania: json.get('id_compania', 0),
      idNotificacion: json.get('id_notificacion', 0),
      idUsuarioNotificacion: json.get('id_usuario_notificacion', 0),
    );
  }
  final int idUsuario;
  final int idCompania;
  final int idNotificacion;
  final int idUsuarioNotificacion;
}
