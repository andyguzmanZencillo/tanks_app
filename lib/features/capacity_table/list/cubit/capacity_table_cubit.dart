import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:uuid/uuid.dart';

part 'capacity_table_state.dart';

class CapacityTableCubit extends Cubit<CapacityTableState> {
  CapacityTableCubit(this.consoleRepository)
      : super(const CapacityTableState());

  final CapacityTableRepository consoleRepository;

  List<CapacityEntity> get aforos => state.capacityEntitys;

  Future<void> getToTank(int idTank) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    const uuid = Uuid();

    final result = await consoleRepository.getToTank(idTank: idTank);

    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            capacityEntitys: ok.map((e) {
              final v4 = uuid.v4();
              return e.copyWith(idStaging: v4);
            }).toList(),
            status: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              capacityEntitys: [],
              status: GeneralStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              capacityEntitys: [],
              status: GeneralStatus.error,
            ),
          );
        }
      },
    );
  }
}
