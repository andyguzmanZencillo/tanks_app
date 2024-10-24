import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/tank_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this.userRepository) : super(const SessionState());
  final UserRepository userRepository;

  void setUserEntity(UserEntity userEntity) {
    emit(state.copyWith(userEntity: userEntity));
  }

  Future<void> getUserEntity() async {
    final result = await userRepository.getUser();
    result.when(
      ok: (ok) {
        emit(state.copyWith(userEntity: ok));
      },
      err: (err) {
        emit(state.copyWith(userEntity: const UserEntity.empty()));
      },
    );
  }

  Future<void> removeUser() async {
    final result = await userRepository.removeUser();
    result.when(
      ok: (ok) {
        emit(state.copyWith(userEntity: const UserEntity.empty()));
      },
      err: (err) {},
    );
  }
}
