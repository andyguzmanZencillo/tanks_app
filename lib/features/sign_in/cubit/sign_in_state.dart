part of 'sign_in_cubit.dart';

class SignInState extends Equatable implements StatusState {
  const SignInState({
    this.dialogMessage = const DialogMessage.empty(),
    this.generalStatus = GeneralStatus.initial,
  });

  @override
  final DialogMessage dialogMessage;

  @override
  final GeneralStatus generalStatus;

  SignInState copyWith({
    DialogMessage? dialogMessage,
    GeneralStatus? generalStatus,
  }) {
    return SignInState(
      dialogMessage: dialogMessage ?? this.dialogMessage,
      generalStatus: generalStatus ?? this.generalStatus,
    );
  }

  @override
  List<Object?> get props => [
        dialogMessage,
        generalStatus,
      ];
}
