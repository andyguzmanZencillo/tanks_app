import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';

part 'tanks_state.dart';

class TanksCubit extends Cubit<TanksState> {
  TanksCubit(this.consoleRepository) : super(const TanksState());

  final TanksRepository consoleRepository;

  void changeSelected(TanksEntity tanksEntity) {
    emit(state.copyWith(selected: tanksEntity));
  }

  Future<void> getAll() async {
    emit(state.copyWith(tanksStatus: TanksStatus.loading));
    final result = await consoleRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            tanksStatus: TanksStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            list: [],
            listCopy: [],
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
            list: ok,
            listCopy: ok,
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
              list: [],
              listCopy: [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              list: [],
              listCopy: [],
              tanksStatus: TanksStatus.error,
            ),
          );
        }
      },
    );
    return result.isOk();
  }

  void search(String text) {
    final listCopy = [...state.listCopy];
    final listSearh = listCopy
        .where(
          (element) =>
              element.descripcion.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(list: listSearh));
  }
}
