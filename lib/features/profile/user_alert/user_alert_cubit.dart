import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'user_alert_state.dart';

class UserAlertCubit extends Cubit<UserAlertState> {
  UserAlertCubit(this.userDeviceRepository) : super(const UserAlertState());

  final UserDeviceRepository userDeviceRepository;

  Future<void> getAll() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await userDeviceRepository.getUserAlert();
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
