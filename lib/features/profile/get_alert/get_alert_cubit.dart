import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'get_alert_state.dart';

class GetAlertCubit extends Cubit<GetAlertState> {
  GetAlertCubit(this.notificationRepository) : super(const GetAlertState());

  final NotificationRepository notificationRepository;
  void onChangeSelected(AlertEntity selected) {
    emit(state.copyWith(selected: selected));
  }

  void onChangeListSelected(AlertEntity selected) {
    final list = [...state.listSelected];

    if (list.any((element) => element.idAlerta == selected.idAlerta)) {
      list.removeWhere((e) => e.idAlerta == selected.idAlerta);
    } else {
      list.add(selected);
    }
    emit(state.copyWith(listSelected: list));
  }

  Future<void> getAlerts() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await notificationRepository.getAlerts();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            status: GeneralStatus.success,
            list: ok,
            selected: ok.first,
          ),
        );
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              status: GeneralStatus.error,
              errorMessage: err.message,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: GeneralStatus.error,
              errorMessage: 'Error desconocido',
            ),
          );
        }
      },
    );
  }
}
