part of 'console_cubit.dart';

class ConsoleState extends Equatable implements StatusState {
  const ConsoleState({
    this.list = const [],
    this.listCopy = const [],
    this.selected = const ConsoleEntity.empty(),
    this.generalStatus = GeneralStatus.initial,
    this.dialogMessage = const DialogMessage.empty(),
  });

  final List<ConsoleEntity> list;
  final List<ConsoleEntity> listCopy;
  final ConsoleEntity selected;

  @override
  final GeneralStatus generalStatus;

  @override
  final DialogMessage dialogMessage;

  ConsoleState copyWith({
    List<ConsoleEntity>? list,
    List<ConsoleEntity>? listCopy,
    ConsoleEntity? selected,
    GeneralStatus? generalStatus,
    DialogMessage? dialogMessage,
  }) {
    return ConsoleState(
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
