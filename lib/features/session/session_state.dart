part of 'session_cubit.dart';

class SessionState extends Equatable {
  const SessionState({
    this.userEntity = const UserEntity.empty(),
  });
  final UserEntity userEntity;

  SessionState copyWith({
    UserEntity? userEntity,
  }) {
    return SessionState(userEntity: userEntity ?? this.userEntity);
  }

  @override
  List<Object> get props => [userEntity];
}
