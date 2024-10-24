import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'console_state.dart';

class ConsoleCubit extends Cubit<ConsoleState> {
  ConsoleCubit(this.consoleRepository) : super(const ConsoleState());

  final ConsoleRepository consoleRepository;
  void onChangedSelected(ConsoleEntity consoleEntity) {
    emit(state.copyWith(selected: consoleEntity));
  }

  Future<bool> getAll() async {
    emit(state.copyWith(consoleStatus: ConsoleStatus.loading));
    final result = await consoleRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            consoleStatus: ConsoleStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            list: [],
            listCopy: [],
            consoleStatus: ConsoleStatus.error,
          ),
        );
      },
    );
    return result.isOk();
  }

  void search(String text) {
    final listCopy = [...state.listCopy];
    final listSearh = listCopy
        .where(
          (element) =>
              element.consola.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(list: listSearh));
  }
}
