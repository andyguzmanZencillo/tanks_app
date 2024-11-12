part of 'console_cubit.dart';

class ConsoleProtocolState extends Equatable implements StatusState {
  const ConsoleProtocolState({
    this.list = const [],
    this.listCopy = const [],
    this.selected = const ConsoleProtocolEntity.empty(),
    this.generalStatus = GeneralStatus.initial,
    this.dialogMessage = const DialogMessage.empty(),
  });

  final List<ConsoleProtocolEntity> list;
  final List<ConsoleProtocolEntity> listCopy;
  final ConsoleProtocolEntity selected;

  @override
  final GeneralStatus generalStatus;

  @override
  final DialogMessage dialogMessage;

  ConsoleProtocolState copyWith({
    List<ConsoleProtocolEntity>? list,
    List<ConsoleProtocolEntity>? listCopy,
    ConsoleProtocolEntity? selected,
    GeneralStatus? generalStatus,
    DialogMessage? dialogMessage,
  }) {
    return ConsoleProtocolState(
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
