part of 'sales_center_cubit.dart';

enum SalesCenterStatus { loading, success, error, initial }

class SalesCenterState extends Equatable {
  const SalesCenterState({
    this.salesCenterStatus = SalesCenterStatus.initial,
    this.list = const [],
    this.listCopy = const [],
    this.selected = const SalesCenterEntity.empty(),
    this.errorMessage,
  });
  final SalesCenterStatus salesCenterStatus;
  final List<SalesCenterEntity> list;
  final List<SalesCenterEntity> listCopy;
  final SalesCenterEntity selected;
  final String? errorMessage;

  SalesCenterState copyWith({
    SalesCenterStatus? salesCenterStatus,
    List<SalesCenterEntity>? list,
    List<SalesCenterEntity>? listCopy,
    SalesCenterEntity? selected,
    String? errorMessage,
  }) {
    return SalesCenterState(
      salesCenterStatus: salesCenterStatus ?? this.salesCenterStatus,
      list: list ?? this.list,
      listCopy: listCopy ?? this.listCopy,
      errorMessage: errorMessage ?? errorMessage,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [
        salesCenterStatus,
        list,
        listCopy,
        errorMessage,
        selected,
      ];
}
