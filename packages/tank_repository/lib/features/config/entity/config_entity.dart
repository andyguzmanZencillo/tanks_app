import 'package:equatable/equatable.dart';

class ConfigEntity extends Equatable {
  const ConfigEntity({
    required this.idCompania,
    required this.idConfiguracion,
    required this.horaInicioZeta,
    required this.horaFinZeta,
  });

  const ConfigEntity.empty()
      : idCompania = 0,
        idConfiguracion = 0,
        horaInicioZeta = '00:00:00',
        horaFinZeta = '00:00:00';
  final int idCompania;
  final int idConfiguracion;
  final String horaInicioZeta;
  final String horaFinZeta;

  // Método copyWith
  ConfigEntity copyWith({
    int? idCompania,
    int? idConfiguracion,
    String? horaInicioZeta,
    String? horaFinZeta,
  }) {
    return ConfigEntity(
      idCompania: idCompania ?? this.idCompania,
      idConfiguracion: idConfiguracion ?? this.idConfiguracion,
      horaInicioZeta: horaInicioZeta ?? this.horaInicioZeta,
      horaFinZeta: horaFinZeta ?? this.horaFinZeta,
    );
  }

  @override
  List<Object> get props => [
        idCompania,
        idConfiguracion,
        horaInicioZeta,
        horaFinZeta,
      ];
}
