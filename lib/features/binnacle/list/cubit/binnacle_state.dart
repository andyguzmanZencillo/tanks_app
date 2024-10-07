part of 'binnacle_cubit.dart';

class BinnacleState extends Equatable {
  const BinnacleState({
    this.generalStatus = GeneralStatus.initial,
    this.list = const [],
    this.selected = const BinnacleEntity.empty(),
    this.errorMessage,
  });
  final GeneralStatus generalStatus;
  final BinnacleEntity selected;
  final List<BinnacleEntity> list;
  final String? errorMessage;

  BinnacleState copyWith({
    GeneralStatus? generalStatus,
    List<BinnacleEntity>? list,
    BinnacleEntity? selected,
    String? errorMessage,
  }) {
    return BinnacleState(
      generalStatus: generalStatus ?? this.generalStatus,
      list: list ?? this.list,
      selected: selected ?? this.selected,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        generalStatus,
        list,
        selected,
        errorMessage,
      ];
}
