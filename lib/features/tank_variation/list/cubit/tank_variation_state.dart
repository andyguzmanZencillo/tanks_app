part of 'tank_variation_cubit.dart';

enum TankVariationStatus { loading, success, error, initial }

class TankVariationState extends Equatable {
  const TankVariationState({
    this.consoleStatus = TankVariationStatus.initial,
    this.consoles = const [],
    this.tankVariationSelected = const TankVariationEntity.empty(),
  });
  final TankVariationStatus consoleStatus;
  final TankVariationEntity tankVariationSelected;
  final List<TankVariationEntity> consoles;

  TankVariationState copyWith({
    TankVariationStatus? consoleStatus,
    List<TankVariationEntity>? consoles,
    TankVariationEntity? tankVariationSelected,
  }) {
    return TankVariationState(
      consoleStatus: consoleStatus ?? this.consoleStatus,
      consoles: consoles ?? this.consoles,
      tankVariationSelected:
          tankVariationSelected ?? this.tankVariationSelected,
    );
  }

  @override
  List<Object> get props => [
        consoleStatus,
        consoles,
        tankVariationSelected,
      ];
}
