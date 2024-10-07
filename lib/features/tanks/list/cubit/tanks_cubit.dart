import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';

part 'tanks_state.dart';

class TanksCubit extends Cubit<TanksState> {
  TanksCubit(this.consoleRepository) : super(const TanksState());

  final TanksRepository consoleRepository;

  void changeSelected(TanksEntity tanksEntity) {
    emit(state.copyWith(tankSelected: tanksEntity));
  }

  Future<void> getAll() async {
    emit(state.copyWith(tanksStatus: TanksStatus.loading));
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

  Future<bool> getToSaleCenter(int idSaleCenter) async {
    emit(state.copyWith(tanksStatus: TanksStatus.loading));
    final result = await consoleRepository.getToSaleCenter(idSaleCenter);
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
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              tanksStatus: TanksStatus.error,
              messageError: err.message,
              tanks: [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              tanks: [],
              tanksStatus: TanksStatus.error,
            ),
          );
        }
      },
    );
    return result.isOk();
  }
}
