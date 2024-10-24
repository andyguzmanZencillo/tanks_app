import 'package:equatable/equatable.dart';

class UserNotificationEntity extends Equatable {
  const UserNotificationEntity({
    required this.idUsuario,
    required this.idCompania,
    required this.idNotificacion,
    required this.idUsuarioNotificacion,
  });

  // Constructor vacío
  const UserNotificationEntity.empty()
      : idUsuario = 0,
        idCompania = 0,
        idNotificacion = 0,
        idUsuarioNotificacion = 0;
  final int idUsuario;
  final int idCompania;
  final int idNotificacion;
  final int idUsuarioNotificacion;

  UserNotificationEntity copyWith({
    int? idUsuario,
    int? idCompania,
    int? idNotificacion,
    int? idUsuarioNotificacion,
  }) {
    return UserNotificationEntity(
      idUsuario: idUsuario ?? this.idUsuario,
      idCompania: idCompania ?? this.idCompania,
      idNotificacion: idNotificacion ?? this.idNotificacion,
      idUsuarioNotificacion:
          idUsuarioNotificacion ?? this.idUsuarioNotificacion,
    );
  }

  @override
  List<Object?> get props =>
      [idUsuario, idCompania, idNotificacion, idUsuarioNotificacion];
}
