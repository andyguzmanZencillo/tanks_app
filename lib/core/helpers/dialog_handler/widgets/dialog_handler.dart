import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/dialog_handler/bloc/dialog_handler_bloc.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';

class DialogHandler extends StatelessWidget {
  const DialogHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DialogHandlerBloc>();
    return BlocSelector<DialogHandlerBloc, DialogHandlerState, DialogType>(
      selector: (state) {
        return state.dialogType;
      },
      builder: (context, type) {
        final dialogData = bloc.state.dialogData;
        final message = bloc.state.message;

        if (type == DialogType.loading) {
          return DialogText(
            text: message,
          );
        } else if (type == DialogType.success) {
          return DialogManagment.good(
            dialogData: dialogData,
          );
        } else if (type == DialogType.info) {
          return DialogManagment.info(
            dialogData: dialogData,
          );
        } else if (type == DialogType.error) {
          return DialogManagment.error(
            dialogData: dialogData,
          );
        }
        return const SizedBox();
      },
    );
  }
}
