import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/profile/perfil/cubit/perfil_cubit.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';

class PerfilListener {
  static BlocListener<PerfilCubit, PerfilState> user() {
    return BlocListener<PerfilCubit, PerfilState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        final message = state.errorMessage;

        if (status == GeneralStatus.loading) {
          context.show(
            const DialogText(
              text: 'Buscando datos del usuario...',
            ),
          );
        } else if (status == GeneralStatus.error) {
          context.pop();
          context.show(
            DialogManagment.error(
              dialogData: DialogData(
                barrierDismissible: false,
                message: message ?? 'Error al buscar datos del usuario',
                title: 'Error',
                onPressed: () {
                  context.pop();
                },
                textButton: 'Cerrar',
              ),
            ),
          );
        } else if (status == GeneralStatus.success) {
          context.pop();
        }
      },
    );
  }
}
