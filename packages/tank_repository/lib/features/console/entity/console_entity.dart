import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/features.dart';

class ConsoleEntity extends Equatable implements ValueExtend<ConsoleEntity> {
  const ConsoleEntity({
    required this.idConsola,
    required this.idCompania,
    required this.consola,
    required this.descripcion,
    required this.idConsolaTanqueProtocolo,
    required this.tipo,
    required this.ip,
    required this.socket,
    required this.puertoSerial,
    required this.contrasenaIp,
  });

  const ConsoleEntity.empty()
      : idConsola = 0,
        idCompania = 0,
        consola = '',
        descripcion = '',
        idConsolaTanqueProtocolo = 0,
        tipo = '',
        ip = '',
        socket = '',
        puertoSerial = '',
        contrasenaIp = '';

  final int idConsola;
  final int idCompania;
  final String consola;
  final String descripcion;
  final int idConsolaTanqueProtocolo;
  final String tipo;
  final String ip;
  final String socket;
  final String puertoSerial;
  final String contrasenaIp;

  @override
  List<Object?> get props => [
        idConsola,
        idCompania,
        consola,
        descripcion,
        idConsolaTanqueProtocolo,
        tipo,
        ip,
        socket,
        puertoSerial,
        contrasenaIp,
      ];

  @override
  String get text => consola;

  @override
  int get id => idConsola;

  @override
  ConsoleEntity? get value => this;

  // Método copyWith añadido
  ConsoleEntity copyWith({
    int? idConsola,
    int? idCompania,
    String? consola,
    String? descripcion,
    int? idConsolaTanqueProtocolo,
    String? tipo,
    String? ip,
    String? socket,
    String? puertoSerial,
    String? contrasenaIp,
  }) {
    return ConsoleEntity(
      idConsola: idConsola ?? this.idConsola,
      idCompania: idCompania ?? this.idCompania,
      consola: consola ?? this.consola,
      descripcion: descripcion ?? this.descripcion,
      idConsolaTanqueProtocolo:
          idConsolaTanqueProtocolo ?? this.idConsolaTanqueProtocolo,
      tipo: tipo ?? this.tipo,
      ip: ip ?? this.ip,
      socket: socket ?? this.socket,
      puertoSerial: puertoSerial ?? this.puertoSerial,
      contrasenaIp: contrasenaIp ?? this.contrasenaIp,
    );
  }
}
