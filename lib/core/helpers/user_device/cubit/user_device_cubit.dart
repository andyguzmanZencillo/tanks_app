import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'user_device_state.dart';

class UserDeviceCubit extends Cubit<UserDeviceState> {
  UserDeviceCubit(this.userDeviceRepository) : super(const UserDeviceState());

  final UserDeviceRepository userDeviceRepository;

  Future<void> register() async {
    final veri = await verification();

    if (!veri) {
      final result = await userDeviceRepository.saveUserDevice();
      result.when(ok: (ok) {}, err: (err) {});
    }
  }

  void onChangeSelected(UserDeviceEntity selected) {
    emit(state.copyWith(selected: selected));
  }

  Future<bool> verification() async {
    final result = await userDeviceRepository.getUserDevice();
    return result.isOk();
  }

  Future<void> getAll() async {
    emit(
      state.copyWith(
        status: GeneralStatus.loading,
        operationType: OperationType.getAll,
      ),
    );
    final result = await userDeviceRepository.getAll();
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
              message: err.message,
            ),
          );
        } else {
          emit(state.copyWith(status: GeneralStatus.error));
        }
      },
    );
  }

  Future<void> deleteItem(int id) async {
    emit(
      state.copyWith(
        status: GeneralStatus.loading,
        operationType: OperationType.delete,
      ),
    );
    final result = await userDeviceRepository.deleteItem(id);
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            status: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        if (err is ResultFailure) {
          emit(
            state.copyWith(
              status: GeneralStatus.error,
              message: err.message,
            ),
          );
        } else {
          emit(state.copyWith(status: GeneralStatus.error));
        }
      },
    );
  }
}
