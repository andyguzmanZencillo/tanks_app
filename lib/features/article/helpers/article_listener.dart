import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/features/article/cubit/article_cubit.dart';

class ArticleListener {
  static BlocListener<ArticleCubit, ArticleState> article() {
    return BlocListener<ArticleCubit, ArticleState>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        final status = state.generalStatus;
        final message = state.dialogMessage;

        if (status == GeneralStatus.loading) {
          context.showLoading(
            message: message.message,
          );
        } else if (status == GeneralStatus.error) {
          context.pop();
          context.showError(
            message: message.message,
            title: message.title ?? 'Error',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        } else if (status == GeneralStatus.success) {
          context.pop();
          context.showGood(
            message: message.message,
            title: message.title ?? '¡Exito!',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        }
      },
    );
  }

  static BlocListener<ArticleCubit, ArticleState> event({
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<ArticleCubit, ArticleState>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        if (state.generalStatus == GeneralStatus.loading) {
          loading?.call();
        } else if (state.generalStatus == GeneralStatus.error) {
          error?.call();
        } else if (state.generalStatus == GeneralStatus.success) {
          success?.call();
        }
      },
    );
  }
}

/*
class GenericListener<C extends BlocBase<S>, S extends StatusState> {
  static BlocListener<C, S> listener({
    required BuildContext context,
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<C, S>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        final status = state.generalStatus;
        final message = state.dialogMessage;

        if (status == GeneralStatus.loading) {
          loading?.call();
          context.showLoading(
            message: message.message,
          );
        } else if (status == GeneralStatus.error) {
          context.pop();
          error?.call();
          context.showError(
            message: message.message,
            title: message.title ?? 'Error',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        } else if (status == GeneralStatus.success) {
          context.pop();
          success?.call();
          context.showGood(
            message: message.message,
            title: message.title ?? '¡Éxito!',
            onPressed: () {
              context.pop();
            },
            textButton: 'Cerrar',
          );
        }
      },
    );
  }

  static BlocListener<C, S> event({
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<C, S>(
      listenWhen: (previous, current) =>
          previous.generalStatus != current.generalStatus,
      listener: (context, state) {
        if (state.generalStatus == GeneralStatus.loading) {
          loading?.call();
        } else if (state.generalStatus == GeneralStatus.error) {
          error?.call();
        } else if (state.generalStatus == GeneralStatus.success) {
          success?.call();
        }
      },
    );
  }
}
*/