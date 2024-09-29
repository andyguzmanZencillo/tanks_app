import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notify_dialog_handler_state.dart';

class NotifyDialogHandlerCubit extends Cubit<NotifyDialogHandlerState> {
  NotifyDialogHandlerCubit() : super(const NotifyDialogHandlerState());
  void onNotification(NotificationInfo notification) {
    emit(state.copyWith(notification));
  }
}
