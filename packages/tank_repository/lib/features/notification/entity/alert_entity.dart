import 'package:equatable/equatable.dart';

class AlertEntity extends Equatable {
  const AlertEntity({
    required this.descripcion,
    required this.idCompania,
    required this.idAlerta,
    required this.nombreAlerta,
  });

  const AlertEntity.empty()
      : descripcion = '',
        idCompania = 0,
        idAlerta = 0,
        nombreAlerta = '';
  final String descripcion;
  final int idCompania;
  final int idAlerta;
  final String nombreAlerta;

  AlertEntity copyWith({
    String? descripcion,
    int? idCompania,
    int? idAlerta,
    String? nombreAlerta,
  }) {
    return AlertEntity(
      descripcion: descripcion ?? this.descripcion,
      idCompania: idCompania ?? this.idCompania,
      idAlerta: idAlerta ?? this.idAlerta,
      nombreAlerta: nombreAlerta ?? this.nombreAlerta,
    );
  }

  @override
  List<Object?> get props => [descripcion, idCompania, idAlerta, nombreAlerta];
}
