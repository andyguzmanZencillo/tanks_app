import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';

part 'dialog_handler_state.dart';

class DialogHandlerCubit extends Cubit<DialogHandlerState> {
  DialogHandlerCubit() : super(const DialogHandlerState());

  void onNotification(DialogInfo dialogInfo) {
    emit(state.copyWith(dialogInfo));
  }
}
