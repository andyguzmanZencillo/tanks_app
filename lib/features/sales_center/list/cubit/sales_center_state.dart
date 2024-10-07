part of 'sales_center_cubit.dart';

enum SalesCenterStatus { loading, success, error, initial }

class SalesCenterState extends Equatable {
  const SalesCenterState({
    this.salesCenterStatus = SalesCenterStatus.initial,
    this.salesCenters = const [],
    this.messageError,
  });
  final SalesCenterStatus salesCenterStatus;
  final List<SalesCenterEntity> salesCenters;
  final String? messageError;

  SalesCenterState copyWith({
    SalesCenterStatus? salesCenterStatus,
    List<SalesCenterEntity>? salesCenters,
    String? messageError,
  }) {
    return SalesCenterState(
      salesCenterStatus: salesCenterStatus ?? this.salesCenterStatus,
      salesCenters: salesCenters ?? this.salesCenters,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [
        salesCenterStatus,
        salesCenters,
        messageError,
      ];
}
