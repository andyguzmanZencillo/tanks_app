part 'dialog_handler_state.dart';

/*class DialogHandlerCubit extends Cubit<DialogHandlerState> {
  DialogHandlerCubit() : super(const DialogHandlerState());

  void onOpenNotification({
    DialogData? dialogData,
    String? message,
    DialogType? dialogType,
  }) {
    if (state.dialogState == DialogState.open) {
      emit(
        state.copyWith(
          closeManually: true,
          dialogState: DialogState.close,
        ),
      );
    }
    emit(
      state.copyWith(
        dialogData: dialogData,
        dialogType: dialogType,
        dialogState: DialogState.open,
        dialogStateLast: state.dialogState,
        message: message,
        closeManually: false,
      ),
    );
  }

  void changeStateDialog(DialogState dialogState) {
    emit(state.copyWith(dialogState: dialogState));
  }
}
*/