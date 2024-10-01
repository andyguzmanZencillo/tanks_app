part of 'upsert_sales_center_cubit.dart';

class UpsertSalesCenterState extends Equatable {
  const UpsertSalesCenterState({
    this.createUpdateStatus = UpsertStatus.initial,
  });
  final UpsertStatus createUpdateStatus;

  UpsertSalesCenterState copyWith({
    UpsertStatus? createUpdateStatus,
  }) {
    return UpsertSalesCenterState(
      createUpdateStatus: createUpdateStatus ?? this.createUpdateStatus,
    );
  }

  @override
  List<Object> get props => [
        createUpdateStatus,
      ];
}
