import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/features.dart';

class TankVariationMultiEntity extends Equatable {
  const TankVariationMultiEntity({
    required this.tank,
    required this.tankVariation,
    required this.tanksVariationLast,
  });

  const TankVariationMultiEntity.empty()
      : tank = const TanksEntity.empty(),
        tankVariation = const [],
        tanksVariationLast = const [];

  final TanksEntity tank;
  final List<TankVariationEntity> tankVariation;
  final List<TankVariationLastEntity> tanksVariationLast;

  TankVariationMultiEntity copyWith({
    TanksEntity? tank,
    List<TankVariationEntity>? tankVariation,
    List<TankVariationLastEntity>? tanksVariationLast,
  }) {
    return TankVariationMultiEntity(
      tank: tank ?? this.tank,
      tankVariation: tankVariation ?? this.tankVariation,
      tanksVariationLast: tanksVariationLast ?? this.tanksVariationLast,
    );
  }

  @override
  List<Object> get props => [tank, tankVariation, tanksVariationLast];
}

class TankVariationLastEntity extends Equatable {
  const TankVariationLastEntity({
    required this.fechaZ,
    required this.inventarioFinalCalculado,
    required this.inventarioFinalFisico,
    required this.aguaFinal,
    required this.saldoFinal,
    required this.rn,
  });

  const TankVariationLastEntity.empty()
      : inventarioFinalCalculado = 0,
        inventarioFinalFisico = 0,
        aguaFinal = 0,
        saldoFinal = 0,
        rn = 0,
        fechaZ = null;

  final DateTime? fechaZ;
  final double inventarioFinalCalculado;
  final double inventarioFinalFisico;
  final double aguaFinal;
  final double saldoFinal;
  final int rn;

  TankVariationLastEntity copyWith({
    DateTime? fechaZ,
    double? inventarioFinalCalculado,
    double? inventarioFinalFisico,
    double? aguaFinal,
    double? saldoFinal,
    int? rn,
  }) {
    return TankVariationLastEntity(
      fechaZ: fechaZ ?? this.fechaZ,
      inventarioFinalCalculado:
          inventarioFinalCalculado ?? this.inventarioFinalCalculado,
      inventarioFinalFisico:
          inventarioFinalFisico ?? this.inventarioFinalFisico,
      aguaFinal: aguaFinal ?? this.aguaFinal,
      saldoFinal: saldoFinal ?? this.saldoFinal,
      rn: rn ?? this.rn,
    );
  }

  @override
  List<Object?> get props => [
        fechaZ,
        inventarioFinalCalculado,
        inventarioFinalFisico,
        aguaFinal,
        saldoFinal,
        rn,
      ];
}
