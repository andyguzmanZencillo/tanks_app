part of 'console_cubit.dart';

enum ConsoleStatus { loading, success, error, initial }

class ConsoleState extends Equatable {
  const ConsoleState({
    this.consoleStatus = ConsoleStatus.initial,
    this.list = const [],
    this.listCopy = const [],
    this.selected = const ConsoleEntity.empty(),
    this.errorMessage,
  });
  final ConsoleStatus consoleStatus;
  final List<ConsoleEntity> list;
  final List<ConsoleEntity> listCopy;
  final ConsoleEntity selected;
  final String? errorMessage;

  ConsoleState copyWith({
    ConsoleStatus? consoleStatus,
    List<ConsoleEntity>? list,
    List<ConsoleEntity>? listCopy,
    ConsoleEntity? selected,
    String? errorMessage,
  }) {
    return ConsoleState(
      consoleStatus: consoleStatus ?? this.consoleStatus,
      list: list ?? this.list,
      listCopy: listCopy ?? this.listCopy,
      selected: selected ?? this.selected,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        consoleStatus,
        list,
        listCopy,
        selected,
        errorMessage,
      ];
}
