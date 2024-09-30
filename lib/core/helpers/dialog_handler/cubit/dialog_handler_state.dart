part of 'dialog_handler_cubit.dart';

enum DialogType { success, error, info, none }

class DialogHandlerState extends Equatable {
  const DialogHandlerState({
    this.dialogInfo = const DialogInfo.empty(),
  });
  final DialogInfo dialogInfo;

  DialogHandlerState copyWith(DialogInfo dialogInfo) {
    return DialogHandlerState(
      dialogInfo: dialogInfo,
    );
  }

  @override
  List<Object> get props => [dialogInfo];
}

class DialogInfo extends Equatable {
  const DialogInfo({
    required this.dialogData,
    required this.dialogType,
  });

  const DialogInfo.empty()
      : dialogType = DialogType.none,
        dialogData = null;

  final DialogType dialogType;
  final DialogData? dialogData;

  @override
  List<Object?> get props => [
        dialogType,
        dialogData,
      ];
}
