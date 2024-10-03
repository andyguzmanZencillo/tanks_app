import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'tanks_state.dart';

class TanksCubit extends Cubit<TanksState> {
  TanksCubit(this.consoleRepository) : super(const TanksState());

  final TanksRepository consoleRepository;

  Future<void> getAll() async {
    emit(state.copyWith(tanksStatus: TanksStatus.success));
    final result = await consoleRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            tanks: ok,
            tanksStatus: TanksStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            tanks: [],
            tanksStatus: TanksStatus.error,
          ),
        );
      },
    );
  }
}
