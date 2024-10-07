import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:uuid/uuid.dart';

part 'capacity_table_state.dart';

class CapacityTableCubit extends Cubit<CapacityTableState> {
  CapacityTableCubit(this.consoleRepository)
      : super(const CapacityTableState());

  final CapacityTableRepository consoleRepository;

  List<CapacityEntity> get aforos => state.capacityEntitys;

  Future<void> getToTank(int idTank) async {
    //await Future<dynamic>.delayed(const Duration(seconds: 5));
    emit(state.copyWith(tanksStatus: CapacityTableStatus.loading));
    const uuid = Uuid();

    final result = await consoleRepository.getToTank(idTank: idTank);

    await Future<dynamic>.delayed(const Duration(seconds: 2));
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            capacityEntitys: ok.map((e) {
              final v4 = uuid.v4();
              return e.copyWith(idStaging: v4);
            }).toList(),
            tanksStatus: CapacityTableStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            capacityEntitys: [],
            tanksStatus: CapacityTableStatus.error,
          ),
        );
      },
    );
  }
}
