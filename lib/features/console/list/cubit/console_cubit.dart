import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'console_state.dart';

class ConsoleCubit extends Cubit<ConsoleState> {
  ConsoleCubit(this.consoleRepository) : super(const ConsoleState());

  final ConsoleRepository consoleRepository;

  Future<void> getAll() async {
    emit(state.copyWith(consoleStatus: ConsoleStatus.success));
    final result = await consoleRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            consoles: ok,
            consoleStatus: ConsoleStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            consoles: [],
            consoleStatus: ConsoleStatus.error,
          ),
        );
      },
    );
  }
}
