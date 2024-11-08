part of 'capacity_table_cubit.dart';

class CapacityTableState extends Equatable {
  const CapacityTableState({
    this.status = GeneralStatus.initial,
    this.capacityEntitys = const [],
    this.errorMessage,
  });
  final GeneralStatus status;
  final List<CapacityEntity> capacityEntitys;

  final String? errorMessage;

  CapacityTableState copyWith({
    GeneralStatus? status,
    List<CapacityEntity>? capacityEntitys,
    String? errorMessage,
  }) {
    return CapacityTableState(
      status: status ?? this.status,
      capacityEntitys: capacityEntitys ?? this.capacityEntitys,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        capacityEntitys,
        errorMessage,
      ];
}
