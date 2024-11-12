part of 'sales_center_cubit.dart';

class SalesCenterState extends Equatable implements StatusState {
  const SalesCenterState({
    this.generalStatus = GeneralStatus.initial,
    this.list = const [],
    this.listCopy = const [],
    this.selected = const SalesCenterEntity.empty(),
    this.dialogMessage = const DialogMessage.empty(),
  });

  @override
  final GeneralStatus generalStatus;
  final List<SalesCenterEntity> list;
  final List<SalesCenterEntity> listCopy;
  final SalesCenterEntity selected;

  @override
  final DialogMessage dialogMessage;

  SalesCenterState copyWith({
    GeneralStatus? generalStatus,
    List<SalesCenterEntity>? list,
    List<SalesCenterEntity>? listCopy,
    SalesCenterEntity? selected,
    DialogMessage? dialogMessage,
  }) {
    return SalesCenterState(
      generalStatus: generalStatus ?? this.generalStatus,
      list: list ?? this.list,
      listCopy: listCopy ?? this.listCopy,
      selected: selected ?? this.selected,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object?> get props => [
        generalStatus,
        list,
        listCopy,
        selected,
        dialogMessage,
      ];
}
