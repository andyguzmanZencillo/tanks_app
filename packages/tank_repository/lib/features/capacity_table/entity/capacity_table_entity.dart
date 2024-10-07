import 'package:equatable/equatable.dart';

class CapacityTableEntity extends Equatable {
  const CapacityTableEntity({
    required this.idTanque,
    required this.idCompania,
    required this.data,
  });
  const CapacityTableEntity.empty()
      : idTanque = 0,
        data = const [],
        idCompania = 0;

  final int idCompania;
  final int idTanque;
  final List<CapacityEntity> data;

  CapacityTableEntity copyWith({
    int? idTanque,
    int? idCompania,
    List<CapacityEntity>? data,
  }) {
    return CapacityTableEntity(
      idTanque: idTanque ?? this.idTanque,
      idCompania: idCompania ?? this.idCompania,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        data,
        idTanque,
        idCompania,
      ];
}

class CapacityEntity {
  CapacityEntity({
    required this.alturaTanque,
    required this.volumen,
    required this.idStaging,
    required this.idAforo,
  });

  const CapacityEntity.empty()
      : alturaTanque = 0,
        volumen = 0,
        idAforo = 0,
        idStaging = '0';

  CapacityEntity copyWith({
    String? idStaging,
    int? idAforo,
    double? alturaTanque,
    double? volumen,
  }) {
    return CapacityEntity(
      idStaging: idStaging ?? this.idStaging,
      idAforo: idAforo ?? this.idAforo,
      alturaTanque: alturaTanque ?? this.alturaTanque,
      volumen: volumen ?? this.volumen,
    );
  }

  final String idStaging;
  final int idAforo;
  final double alturaTanque;
  final double volumen;
}
