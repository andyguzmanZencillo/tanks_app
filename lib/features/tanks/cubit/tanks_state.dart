part of 'tanks_cubit.dart';

class TanksState extends Equatable implements StatusState {
  const TanksState({
    this.list = const [],
    this.listCopy = const [],
    this.selected = const TanksEntity.empty(),
    this.generalStatus = GeneralStatus.initial,
    this.dialogMessage = const DialogMessage.empty(),
  });

  final List<TanksEntity> list;
  final List<TanksEntity> listCopy;
  final TanksEntity selected;

  @override
  final GeneralStatus generalStatus;

  @override
  final DialogMessage dialogMessage;

  TanksState copyWith({
    List<TanksEntity>? list,
    List<TanksEntity>? listCopy,
    TanksEntity? selected,
    GeneralStatus? generalStatus,
    DialogMessage? dialogMessage,
  }) {
    return TanksState(
      list: list ?? this.list,
      listCopy: listCopy ?? this.listCopy,
      selected: selected ?? this.selected,
      generalStatus: generalStatus ?? this.generalStatus,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }

  @override
  List<Object?> get props => [
        list,
        listCopy,
        selected,
        generalStatus,
        dialogMessage,
      ];
}
