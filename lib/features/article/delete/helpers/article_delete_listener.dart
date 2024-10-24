import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/delete/cubit/article_delete_cubit.dart';

class ArticleDeleteListener {
  static BlocListener<ArticleDeleteCubit, ArticleDeleteState> article({
    void Function()? onTap,
  }) {
    return BlocListener<ArticleDeleteCubit, ArticleDeleteState>(
      listenWhen: (previous, current) =>
          previous.deleteStatus != current.deleteStatus,
      listener: (context, state) {
        final status = state.deleteStatus;
        final errorMessage = state.errorMessage;

        if (status == DeleteStatus.loading) {
          const text = 'Eliminando artículo...';
          FocusManager.instance.primaryFocus?.unfocus();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: text,
              );
            },
          );
        } else if (status == DeleteStatus.error) {
          final message = errorMessage ?? 'No se pudo eliminar el artículo.';

          context.pop();

          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message,
                  title: 'Error al eliminar artículo',
                  onPressed: () {
                    onTap?.call();
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (status == DeleteStatus.success) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.good(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: 'Eliminación exitosa.',
                  title: 'Artículo eliminado',
                  onPressed: () {
                    onTap?.call();
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        }
      },
    );
  }

  static BlocListener<ArticleDeleteCubit, ArticleDeleteState> event({
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<ArticleDeleteCubit, ArticleDeleteState>(
      listenWhen: (previous, current) =>
          previous.deleteStatus != current.deleteStatus,
      listener: (context, state) {
        if (state.deleteStatus == DeleteStatus.loading) {
          loading?.call();
        } else if (state.deleteStatus == DeleteStatus.error) {
          error?.call();
        } else if (state.deleteStatus == DeleteStatus.success) {
          success?.call();
        }
      },
    );
  }
}
