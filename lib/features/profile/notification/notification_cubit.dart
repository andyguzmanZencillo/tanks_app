import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepository)
      : super(const NotificationState());
  final NotificationRepository notificationRepository;

  void onChangeSelected(NotificationEntity selected) {
    emit(state.copyWith(selected: selected));
  }

  void onChangeListSelected(NotificationEntity selected) {
    final list = [...state.listSelected];

    if (list
        .any((element) => element.idNotificacion == selected.idNotificacion)) {
      list.removeWhere((e) => e.idNotificacion == selected.idNotificacion);
    } else {
      list.add(selected);
    }
    emit(state.copyWith(listSelected: list));
  }

  Future<void> getAll() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await notificationRepository.getNotifications();
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
        if (err is InvalidDataFailure) {
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
