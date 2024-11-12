part of 'upsert_capacity_table_cubit.dart';

class UpsertCapacityTableState extends Equatable implements StatusState {
  const UpsertCapacityTableState({
    this.selectedEditCapacity = const CapacityEntity.empty(),
    this.capacityEntitys = const [],
    this.dialogMessage =
        const DialogMessage.empty(), // inicialización predeterminada
    this.generalStatus = GeneralStatus.initial, // inicialización predeterminada
  });

  final List<CapacityEntity> capacityEntitys;
  final CapacityEntity selectedEditCapacity;

  @override
  final DialogMessage dialogMessage;

  @override
  final GeneralStatus generalStatus;

  UpsertCapacityTableState copyWith({
    List<CapacityEntity>? capacityEntitys,
    CapacityEntity? selectedEditCapacity,
    DialogMessage? dialogMessage,
    GeneralStatus? generalStatus,
  }) {
    return UpsertCapacityTableState(
      capacityEntitys: capacityEntitys ?? this.capacityEntitys,
      selectedEditCapacity: selectedEditCapacity ?? this.selectedEditCapacity,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      generalStatus: generalStatus ?? this.generalStatus,
    );
  }

  @override
  List<Object?> get props => [
        capacityEntitys,
        selectedEditCapacity,
        dialogMessage,
        generalStatus,
      ];
}
