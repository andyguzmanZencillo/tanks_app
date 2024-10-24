import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/list/cubit/article_list_cubit.dart';

class ArticleListListener {
  static BlocListener<ArticleListCubit, ArticleListState> article() {
    return BlocListener<ArticleListCubit, ArticleListState>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        final status = state.generalStatus;
        final message = state.errorMessage;

        if (status == GeneralStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Estamos buscando los artículos. Por favor, espere...',
              );
            },
          );
        } else if (status == GeneralStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message ??
                      'No pudimos cargar los artículos. Verifique su conexión e intente de nuevo.',
                  title: 'Error al cargar',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (status == GeneralStatus.success) {
          context.pop();
        }
      },
    );
  }
}
