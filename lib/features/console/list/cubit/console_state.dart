part of 'console_cubit.dart';

enum ConsoleStatus { loading, success, error, initial }

class ConsoleState extends Equatable {
  const ConsoleState({
    this.consoleStatus = ConsoleStatus.initial,
    this.consoles = const [],
  });
  final ConsoleStatus consoleStatus;
  final List<ConsoleEntity> consoles;

  ConsoleState copyWith({
    ConsoleStatus? consoleStatus,
    List<ConsoleEntity>? consoles,
  }) {
    return ConsoleState(
      consoleStatus: consoleStatus ?? this.consoleStatus,
      consoles: consoles ?? this.consoles,
    );
  }

  @override
  List<Object> get props => [consoleStatus, consoles];
}
