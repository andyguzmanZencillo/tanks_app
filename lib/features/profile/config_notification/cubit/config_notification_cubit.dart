import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'config_notification_state.dart';

class ConfigNotificationCubit extends Cubit<ConfigNotificationState> {
  ConfigNotificationCubit(this.notificationRepository)
      : super(const ConfigNotificationState());
  final NotificationRepository notificationRepository;

  Future<void> save({
    required List<int> idAlerta,
    required List<int> idNotificacion,
  }) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await notificationRepository.save(
      idAlerta: idAlerta,
      idNotificacion: idNotificacion,
    );
    result.when(
      ok: (ok) {
        emit(state.copyWith(status: GeneralStatus.success));
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              errorMessage: err.message,
              status: GeneralStatus.error,
            ),
          );
        } else {
          emit(state.copyWith(status: GeneralStatus.error));
        }
      },
    );
  }
}
