import 'package:tank_api/core/extends/json_extends.dart'; // Asegúrate de tener esta extensión

class NotificationResponse {
  const NotificationResponse({
    required this.descripcion,
    required this.idCompania,
    required this.idNotificacion,
    required this.nombreNotificacion,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      descripcion: json.get<String>('descripcion', ''),
      idCompania: json.get<int>('id_compania', 0),
      idNotificacion: json.get<int>('id_notificacion', 0),
      nombreNotificacion: json.get<String>(
        'nombre_notificacion',
        '',
      ),
    );
  }

  final String descripcion;
  final int idCompania;
  final int idNotificacion;
  final String nombreNotificacion;
}
