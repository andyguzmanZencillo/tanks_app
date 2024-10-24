import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/user_device/entity/user_notification_entity.dart';
import 'package:tank_repository/features/user_device/repository/user_device_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'get_notification_state.dart';

class GetUserNotificationCubit extends Cubit<GetUserNotificationState> {
  GetUserNotificationCubit(this.userDeviceRepository)
      : super(const GetUserNotificationState());
  final UserDeviceRepository userDeviceRepository;
  Future<void> getAll() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await userDeviceRepository.getUserNotification();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            status: GeneralStatus.success,
            list: ok,
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
