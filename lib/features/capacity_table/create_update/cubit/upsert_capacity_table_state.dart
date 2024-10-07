part of 'upsert_capacity_table_cubit.dart';

class UpsertCapacityTableState extends Equatable {
  const UpsertCapacityTableState({
    this.upsertStatus = UpsertStatus.initial,
    this.errorMessage,
    this.selectedEditCapacity = const CapacityEntity.empty(),
    this.capacityEntitys = const [],
  });

  final UpsertStatus upsertStatus;
  final String? errorMessage;
  final List<CapacityEntity> capacityEntitys;
  final CapacityEntity selectedEditCapacity;

  UpsertCapacityTableState copyWith({
    UpsertStatus? upsertStatus,
    String? errorMessage,
    List<CapacityEntity>? capacityEntitys,
    CapacityEntity? selectedEditCapacity,
  }) {
    return UpsertCapacityTableState(
      upsertStatus: upsertStatus ?? this.upsertStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      capacityEntitys: capacityEntitys ?? this.capacityEntitys,
      selectedEditCapacity: selectedEditCapacity ?? this.selectedEditCapacity,
    );
  }

  @override
  List<Object?> get props => [
        upsertStatus,
        errorMessage,
        capacityEntitys,
        selectedEditCapacity,
      ];
}
