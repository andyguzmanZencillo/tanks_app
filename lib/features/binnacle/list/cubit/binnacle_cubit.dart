import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'binnacle_state.dart';

class BinnacleCubit extends Cubit<BinnacleState> {
  BinnacleCubit(this.consoleRepository) : super(const BinnacleState());

  final BinnacleRepository consoleRepository;

  void changeSelected(BinnacleEntity configSelected) {
    emit(state.copyWith(selected: configSelected));
  }

  Future<void> getAll() async {
    emit(state.copyWith(generalStatus: GeneralStatus.loading));
    final result = await consoleRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            generalStatus: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              list: [],
              generalStatus: GeneralStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              list: [],
              generalStatus: GeneralStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
      },
    );
  }
}
