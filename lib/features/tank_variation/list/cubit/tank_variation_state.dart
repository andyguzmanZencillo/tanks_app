part of 'tank_variation_cubit.dart';

class TankVariationState extends Equatable {
  const TankVariationState({
    this.status = GeneralStatus.initial,
    this.list = const [],
    this.selected = const TankVariationEntity.empty(),
    this.selectedPro = const TankVariationMultiEntity.empty(),
    this.listPro = const [],
    this.dateSearch,
  });

  final GeneralStatus status;
  final TankVariationEntity selected;
  final List<TankVariationEntity> list;
  final TankVariationMultiEntity selectedPro;
  final List<TankVariationMultiEntity> listPro;
  final DateTime? dateSearch;

  TankVariationState copyWith({
    GeneralStatus? status,
    List<TankVariationEntity>? list,
    TankVariationEntity? selected,
    TankVariationMultiEntity? selectedPro,
    List<TankVariationMultiEntity>? listPro,
    DateTime? dateSearch,
  }) {
    return TankVariationState(
      status: status ?? this.status,
      list: list ?? this.list,
      selected: selected ?? this.selected,
      selectedPro: selectedPro ?? this.selectedPro,
      listPro: listPro ?? this.listPro,
      dateSearch: dateSearch ?? this.dateSearch,
    );
  }

  @override
  List<Object?> get props => [
        status,
        list,
        selected,
        selectedPro,
        listPro,
        dateSearch,
      ];
}
