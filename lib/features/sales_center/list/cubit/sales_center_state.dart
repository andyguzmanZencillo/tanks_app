part of 'sales_center_cubit.dart';

enum SalesCenterStatus { loading, success, error, initial }

class SalesCenterState extends Equatable {
  const SalesCenterState({
    this.salesCenterStatus = SalesCenterStatus.initial,
    this.salesCenters = const [],
  });
  final SalesCenterStatus salesCenterStatus;
  final List<SalesCenterEntity> salesCenters;

  SalesCenterState copyWith({
    SalesCenterStatus? salesCenterStatus,
    List<SalesCenterEntity>? salesCenters,
  }) {
    return SalesCenterState(
      salesCenterStatus: salesCenterStatus ?? this.salesCenterStatus,
      salesCenters: salesCenters ?? this.salesCenters,
    );
  }

  @override
  List<Object> get props => [salesCenterStatus, salesCenters];
}
