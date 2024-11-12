part of 'capacity_table_cubit.dart';

class CapacityTableState extends Equatable implements StatusState {
  const CapacityTableState({
    this.capacityEntitys = const [],
    this.generalStatus = GeneralStatus.initial,
    this.dialogMessage = const DialogMessage.empty(),
  });

  final List<CapacityEntity> capacityEntitys;

  @override
  final GeneralStatus generalStatus;

  @override
  final DialogMessage dialogMessage;

  CapacityTableState copyWith({
    List<CapacityEntity>? capacityEntitys,
    GeneralStatus? generalStatus,
    DialogMessage? dialogMessage,
  }) {
    return CapacityTableState(
      capacityEntitys: capacityEntitys ?? this.capacityEntitys,
      generalStatus: generalStatus ?? this.generalStatus,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object?> get props => [
        capacityEntitys,
        generalStatus,
        dialogMessage,
      ];
}
