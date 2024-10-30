part of 'tank_variation_cubit.dart';

class TankVariationState extends Equatable {
  const TankVariationState({
    this.status = GeneralStatus.initial,
    this.list = const [],
    this.selected = const TankVariationEntity.empty(),
  });
  final GeneralStatus status;
  final TankVariationEntity selected;
  final List<TankVariationEntity> list;

  TankVariationState copyWith({
    GeneralStatus? status,
    List<TankVariationEntity>? list,
    TankVariationEntity? selected,
  }) {
    return TankVariationState(
      status: status ?? this.status,
      list: list ?? this.list,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object> get props => [
        status,
        list,
        selected,
      ];
}
