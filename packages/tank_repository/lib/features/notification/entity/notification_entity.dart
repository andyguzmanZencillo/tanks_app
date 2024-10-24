import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.descripcion,
    required this.idCompania,
    required this.idNotificacion,
    required this.nombreNotificacion,
  });

  const NotificationEntity.empty()
      : descripcion = '',
        idCompania = 0,
        idNotificacion = 0,
        nombreNotificacion = '';
  final String descripcion;
  final int idCompania;
  final int idNotificacion;
  final String nombreNotificacion;

  NotificationEntity copyWith({
    String? descripcion,
    int? idCompania,
    int? idNotificacion,
    String? nombreNotificacion,
  }) {
    return NotificationEntity(
      descripcion: descripcion ?? this.descripcion,
      idCompania: idCompania ?? this.idCompania,
      idNotificacion: idNotificacion ?? this.idNotificacion,
      nombreNotificacion: nombreNotificacion ?? this.nombreNotificacion,
    );
  }

  @override
  List<Object?> get props =>
      [descripcion, idCompania, idNotificacion, nombreNotificacion];
}
