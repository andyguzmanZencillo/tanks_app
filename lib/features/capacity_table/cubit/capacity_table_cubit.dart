import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/dialog_info.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/features/capacity_table/helpers/message_capacity_table_listener.dart';
import 'package:uuid/uuid.dart';

part 'capacity_table_state.dart';

class CapacityTableCubit extends Cubit<CapacityTableState> {
  CapacityTableCubit(this.consoleRepository)
      : super(const CapacityTableState());

  final CapacityTableRepository consoleRepository;

  List<CapacityEntity> get aforos => state.capacityEntitys;

  Future<void> getToTank(int idTank) async {
    emit(
      state.copyWith(
        generalStatus: GeneralStatus.loading,
        dialogMessage: MessageCapacityTableListener.loadingGet,
      ),
    );
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
            generalStatus: GeneralStatus.success,
            dialogMessage: MessageCapacityTableListener.successGet,
          ),
        );
      },
      err: (err) {
        if (err is InvalidDataFailure) {
          emit(
            state.copyWith(
              capacityEntitys: [],
              generalStatus: GeneralStatus.error,
              dialogMessage:
                  DialogMessage(message: err.message, showError: false),
            ),
          );
        } else {
          emit(
            state.copyWith(
              capacityEntitys: [],
              generalStatus: GeneralStatus.error,
              dialogMessage: MessageCapacityTableListener.error,
            ),
          );
        }
      },
    );
  }
}
