import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'capacity_table_state.dart';

class CapacityTableCubit extends Cubit<CapacityTableState> {
  CapacityTableCubit(this.consoleRepository)
      : super(const CapacityTableState());

  final CapacityTableRepository consoleRepository;

  Future<void> getAll() async {
    emit(state.copyWith(tanksStatus: CapacityTableStatus.success));
    final result = await consoleRepository.getAll();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            tanks: ok,
            tanksStatus: CapacityTableStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            tanks: [],
            tanksStatus: CapacityTableStatus.error,
          ),
        );
      },
    );
  }

  void addStagingItem() {
    emit(
      state.copyWith(
        tanksStaging: [
          ...state.tanksStaging,
          CapacityTableEntity(
            idAforo: 0,
            idStaging: DateTime.now().millisecondsSinceEpoch,
            alturaTanque: 0,
            volumen: 0,
            idTanque: 0,
            idCompania: 0,
          ),
        ],
      ),
    );
  }

  void removeStagingItem(int idStaging) {
    final items = [...state.tanksStaging];
    items.removeWhere((element) => element.idStaging == idStaging);

    emit(
      state.copyWith(
        tanksStaging: items,
      ),
    );
  }

  Future<void> getToTank(int idTank) async {
    emit(state.copyWith(tanksStatus: CapacityTableStatus.success));
    final result = await consoleRepository.getToTank(idTank: idTank);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            tanks: ok,
            tanksStaging: ok,
            tanksStatus: CapacityTableStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            tanks: [],
            tanksStaging: [],
            tanksStatus: CapacityTableStatus.error,
          ),
        );
      },
    );
  }
}
