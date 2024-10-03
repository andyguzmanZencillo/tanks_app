part of 'capacity_table_cubit.dart';

enum CapacityTableStatus { loading, success, error, initial }

class CapacityTableState extends Equatable {
  const CapacityTableState({
    this.tanksStatus = CapacityTableStatus.initial,
    this.tanks = const [],
    this.tanksStaging = const [],
  });
  final CapacityTableStatus tanksStatus;
  final List<CapacityTableEntity> tanks;
  final List<CapacityTableEntity> tanksStaging;

  CapacityTableState copyWith({
    CapacityTableStatus? tanksStatus,
    List<CapacityTableEntity>? tanks,
    List<CapacityTableEntity>? tanksStaging,
  }) {
    return CapacityTableState(
      tanksStatus: tanksStatus ?? this.tanksStatus,
      tanks: tanks ?? this.tanks,
      tanksStaging: tanksStaging ?? this.tanksStaging,
    );
  }

  @override
  List<Object> get props => [tanksStatus, tanks, tanksStaging];
}
