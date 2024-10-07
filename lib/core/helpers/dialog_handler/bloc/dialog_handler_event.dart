part of 'dialog_handler_bloc.dart';

class DialogHandlerEvent extends Equatable {
  const DialogHandlerEvent();

  @override
  List<Object> get props => [];
}

class OnOpenNotification extends DialogHandlerEvent {
  const OnOpenNotification({
    this.message,
    this.dialogType,
    this.dialogData,
  });
  final DialogData? dialogData;
  final String? message;
  final DialogType? dialogType;
}

class ChangeStateDialog extends DialogHandlerEvent {
  const ChangeStateDialog(
    this.dialogState,
  );
  final DialogState dialogState;
}

class CloseDialog extends DialogHandlerEvent {
  const CloseDialog();
}
