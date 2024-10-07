import 'package:equatable/equatable.dart';

class BinnacleEntity extends Equatable {
  // O puedes usar TimeOfDay si lo prefieres

  const BinnacleEntity({
    required this.idBitacora,
    required this.idCompania,
    required this.idTanque,
    required this.idCentroVenta,
    required this.descripcion,
    required this.codigoTanque,
    required this.saldo,
    required this.agua,
    required this.descargue,
    required this.saldoAltura,
    required this.aguaAltura,
    required this.volumenReal,
    required this.fechaLectura,
    required this.hora,
  });

  const BinnacleEntity.empty()
      : idBitacora = 0,
        idCompania = 0,
        idTanque = 0,
        idCentroVenta = 0,
        descripcion = '',
        codigoTanque = '',
        saldo = 0.0,
        agua = 0.0,
        descargue = 0.0,
        saldoAltura = 0.0,
        aguaAltura = 0.0,
        volumenReal = 0.0,
        fechaLectura = '',
        hora = '';

  final int idBitacora;
  final int idCompania;
  final int idTanque;
  final int idCentroVenta;
  final String descripcion;
  final String codigoTanque;
  final double saldo;
  final double agua;
  final double descargue;
  final double saldoAltura;
  final double aguaAltura;
  final double volumenReal;
  final String fechaLectura; // O puedes usar DateTime
  final String hora;

  @override
  List<Object?> get props => [
        idBitacora,
        idCompania,
        idTanque,
        idCentroVenta,
        descripcion,
        codigoTanque,
        saldo,
        agua,
        descargue,
        saldoAltura,
        aguaAltura,
        volumenReal,
        fechaLectura,
        hora,
      ];
}
