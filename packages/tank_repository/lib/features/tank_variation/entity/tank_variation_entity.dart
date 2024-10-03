import 'package:equatable/equatable.dart';

class TankVariationEntity extends Equatable {
  const TankVariationEntity({
    required this.idAforo,
    required this.alturaTanque,
    required this.volumen,
    required this.idTanque,
    required this.idCompania,
  });
  const TankVariationEntity.empty()
      : idAforo = 0,
        alturaTanque = 0,
        volumen = 0,
        idTanque = 0,
        idCompania = 0;

  final int idAforo;
  final int idCompania;
  final int idTanque;
  final double alturaTanque;
  final double volumen;

  TankVariationEntity copyWith({
    int? idAforo,
    double? alturaTanque,
    double? volumen,
    int? idTanque,
    int? idCompania,
  }) {
    return TankVariationEntity(
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
