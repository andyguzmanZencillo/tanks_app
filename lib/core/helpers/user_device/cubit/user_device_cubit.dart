import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  Future<bool> verification() async {
    final result = await userDeviceRepository.getUserDevice();
    return result.isOk();
  }
}
