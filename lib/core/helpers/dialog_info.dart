import 'package:equatable/equatable.dart';

class DialogMessage extends Equatable {
  const DialogMessage({
    required this.message,
    this.title,
    this.showSuccess = true,
    this.showError = true,
    this.showDialog = true,
    this.pop = true,
  });

  const DialogMessage.empty()
      : message = '',
        showSuccess = true,
        showError = true,
        showDialog = true,
        pop = true,
        title = null;

  final String? title;
  final String message;

  final bool showSuccess;
  final bool showError;
  final bool showDialog;

  final bool pop;

  @override
  List<Object?> get props => [
        message,
        title,
        showSuccess,
        showError,
        showDialog,
        pop,
      ];
}
