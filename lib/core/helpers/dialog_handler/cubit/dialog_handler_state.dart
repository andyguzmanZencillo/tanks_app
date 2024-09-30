part of 'dialog_handler_cubit.dart';

enum DialogType { loading, success, error, info, none }

enum DialogState { open, close }

class DialogHandlerState extends Equatable {
  const DialogHandlerState({
    this.dialogData = const DialogData.empty(),
    this.message = '',
    this.dialogState = DialogState.close,
    this.closeManually = false,
    this.dialogType = DialogType.none,
  });
  final DialogData dialogData;
  final DialogType dialogType;
  final String message;
  final DialogState dialogState;

  final bool closeManually;

  DialogHandlerState copyWith({
    DialogData? dialogData,
    DialogState? dialogState,
    String? message,
    DialogType? dialogType,
    bool? closeManually,
  }) {
    return DialogHandlerState(
      dialogData: dialogData ?? this.dialogData,
      dialogState: dialogState ?? this.dialogState,
      message: message ?? this.message,
      dialogType: dialogType ?? this.dialogType,
      closeManually: closeManually ?? this.closeManually,
    );
  }

  @override
  List<Object> get props => [
        dialogData,
        dialogState,
        message,
        closeManually,
        dialogType,
      ];
}
