import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';

part 'dialog_handler_event.dart';
part 'dialog_handler_state.dart';

class DialogHandlerBloc extends Bloc<DialogHandlerEvent, DialogHandlerState> {
  DialogHandlerBloc() : super(const DialogHandlerState()) {
    on<OnOpenNotification>(_onOpenNotification, transformer: sequential());
    on<ChangeStateDialog>(_changeStateDialog, transformer: sequential());
    on<CloseDialog>(_closeDialog, transformer: sequential());
  }
  EventTransformer<E> sequential<E>() {
    return (events, mapper) => events.asyncExpand(mapper);
  }

  void _onOpenNotification(
    OnOpenNotification event,
    Emitter<DialogHandlerState> emit,
  ) {
    emit(
      state.copyWith(
        dialogData: event.dialogData,
        dialogType: event.dialogType,
        dialogState: DialogState.open,
        dialogStateLast: state.dialogState,
        message: event.message,
        closeManually: false,
      ),
    );
  }

  void _changeStateDialog(
    ChangeStateDialog event,
    Emitter<DialogHandlerState> emit,
  ) {
    emit(state.copyWith(dialogState: event.dialogState));
  }

  void _closeDialog(
    CloseDialog event,
    Emitter<DialogHandlerState> emit,
  ) {
    if (state.dialogState == DialogState.open) {
      emit(
        state.copyWith(
          closeManually: true,
          dialogState: DialogState.close,
        ),
      );
    }
  }
}
