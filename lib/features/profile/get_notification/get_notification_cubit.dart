import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'get_notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
  GetNotificationCubit(this.notificationRepository)
      : super(const GetNotificationState());
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

  Future<void> getNotifications() async {
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
