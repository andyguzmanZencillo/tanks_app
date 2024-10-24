import 'package:equatable/equatable.dart';

class UserDeviceEntity extends Equatable {
  const UserDeviceEntity({
    required this.token,
    required this.idUsuario,
    required this.dispositivo,
    required this.idCompania,
    required this.idUsuarioDispositivo,
  });

  const UserDeviceEntity.empty()
      : token = '',
        idUsuario = 0,
        dispositivo = '',
        idCompania = 0,
        idUsuarioDispositivo = 0;
  final String token;
  final int idUsuario;
  final String dispositivo;
  final int idCompania;
  final int idUsuarioDispositivo;

  UserDeviceEntity copyWith({
    String? token,
    int? idUsuario,
    String? dispositivo,
    int? idCompania,
    int? idUsuarioDispositivo,
  }) {
    return UserDeviceEntity(
      token: token ?? this.token,
      idUsuario: idUsuario ?? this.idUsuario,
      dispositivo: dispositivo ?? this.dispositivo,
      idCompania: idCompania ?? this.idCompania,
      idUsuarioDispositivo: idUsuarioDispositivo ?? this.idUsuarioDispositivo,
    );
  }

  @override
  List<Object?> get props =>
      [token, idUsuario, dispositivo, idCompania, idUsuarioDispositivo];
}
