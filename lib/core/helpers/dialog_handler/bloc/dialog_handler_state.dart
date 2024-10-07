part of 'dialog_handler_bloc.dart';

class DialogHandlerState extends Equatable {
  const DialogHandlerState({
    this.dialogData = const DialogData.empty(),
    this.message = '',
    this.dialogState = DialogState.close,
    this.dialogStateLast = DialogState.close,
    this.closeManually = false,
    this.dialogType = DialogType.none,
  });
  final DialogData dialogData;
  final DialogType dialogType;
  final String message;
  final DialogState dialogState;
  final DialogState dialogStateLast;

  final bool closeManually;

  DialogHandlerState copyWith({
    DialogData? dialogData,
    DialogState? dialogState,
    DialogState? dialogStateLast,
    String? message,
    DialogType? dialogType,
    bool? closeManually,
  }) {
    return DialogHandlerState(
      dialogData: dialogData ?? this.dialogData,
      dialogState: dialogState ?? this.dialogState,
      dialogStateLast: dialogStateLast ?? this.dialogStateLast,
      message: message ?? this.message,
      dialogType: dialogType ?? this.dialogType,
      closeManually: closeManually ?? this.closeManually,
    );
  }

  @override
  List<Object> get props => [
        dialogData,
        dialogState,
        dialogStateLast,
        message,
        closeManually,
        dialogType,
      ];
}
