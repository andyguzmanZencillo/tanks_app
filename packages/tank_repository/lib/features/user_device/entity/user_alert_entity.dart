import 'package:equatable/equatable.dart';

class UserAlertEntity extends Equatable {
  const UserAlertEntity({
    required this.idAlerta,
    required this.idUsuario,
    required this.idCompania,
    required this.idUsuarioAlerta,
  });

  // Constructor vacío
  const UserAlertEntity.empty()
      : idAlerta = 0,
        idUsuario = 0,
        idCompania = 0,
        idUsuarioAlerta = 0;
  final int idAlerta;
  final int idUsuario;
  final int idCompania;
  final int idUsuarioAlerta;

  UserAlertEntity copyWith({
    int? idAlerta,
    int? idUsuario,
    int? idCompania,
    int? idUsuarioAlerta,
  }) {
    return UserAlertEntity(
      idAlerta: idAlerta ?? this.idAlerta,
      idUsuario: idUsuario ?? this.idUsuario,
      idCompania: idCompania ?? this.idCompania,
      idUsuarioAlerta: idUsuarioAlerta ?? this.idUsuarioAlerta,
    );
  }

  @override
  List<Object?> get props => [idAlerta, idUsuario, idCompania, idUsuarioAlerta];
}
