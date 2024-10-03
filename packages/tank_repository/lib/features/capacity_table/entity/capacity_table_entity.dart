import 'package:equatable/equatable.dart';

class CapacityTableEntity extends Equatable {
  const CapacityTableEntity({
    required this.idAforo,
    required this.alturaTanque,
    required this.volumen,
    required this.idTanque,
    required this.idCompania,
    this.idStaging = 0,
  });
  const CapacityTableEntity.empty()
      : idAforo = 0,
        alturaTanque = 0,
        volumen = 0,
        idTanque = 0,
        idStaging = 0,
        idCompania = 0;

  final int idAforo;
  final int idCompania;
  final int idTanque;
  final double alturaTanque;
  final double volumen;

  final int idStaging;

  CapacityTableEntity copyWith({
    int? idAforo,
    double? alturaTanque,
    double? volumen,
    int? idTanque,
    int? idCompania,
  }) {
    return CapacityTableEntity(
      idAforo: idAforo ?? this.idAforo,
      alturaTanque: alturaTanque ?? this.alturaTanque,
      volumen: volumen ?? this.volumen,
      idTanque: idTanque ?? this.idTanque,
      idCompania: idCompania ?? this.idCompania,
    );
  }

  @override
  List<Object?> get props => [
        idAforo,
        alturaTanque,
        volumen,
        idTanque,
        idCompania,
      ];
}
