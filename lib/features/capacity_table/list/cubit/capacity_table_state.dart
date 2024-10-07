part of 'capacity_table_cubit.dart';

enum CapacityTableStatus { loading, success, error, initial }

class CapacityTableState extends Equatable {
  const CapacityTableState({
    this.tanksStatus = CapacityTableStatus.initial,
    this.capacityEntitys = const [],
    this.errorMessage,
  });
  final CapacityTableStatus tanksStatus;
  final List<CapacityEntity> capacityEntitys;

  final String? errorMessage;

  CapacityTableState copyWith({
    CapacityTableStatus? tanksStatus,
    List<CapacityEntity>? capacityEntitys,
    String? errorMessage,
  }) {
    return CapacityTableState(
      tanksStatus: tanksStatus ?? this.tanksStatus,
      capacityEntitys: capacityEntitys ?? this.capacityEntitys,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        tanksStatus,
        capacityEntitys,
        errorMessage,
      ];
}
