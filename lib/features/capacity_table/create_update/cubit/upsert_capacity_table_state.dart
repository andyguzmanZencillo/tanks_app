part of 'upsert_capacity_table_cubit.dart';

class UpsertCapacityTableState extends Equatable {
  const UpsertCapacityTableState({
    this.upsertStatus = UpsertStatus.initial,
    this.errorMessage,
  });
  final UpsertStatus upsertStatus;
  final String? errorMessage;

  UpsertCapacityTableState copyWith({
    UpsertStatus? upsertStatus,
    String? errorMessage,
  }) {
    return UpsertCapacityTableState(
      upsertStatus: upsertStatus ?? this.upsertStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [upsertStatus, errorMessage];
}
