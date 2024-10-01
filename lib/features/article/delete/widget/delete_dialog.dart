import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/delete/cubit/article_delete_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    required this.article,
    super.key,
  });
  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ArticleDeleteCubit>(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ArticleDeleteCubit>();
          return Dialog(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.red,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Confirmar Eliminación',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '¿Estás seguro de que deseas eliminar el siguiente artículo?',
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nombre: ${article.articulo}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Descripción: ${article.descripcion}'),
                      Text('Color: ${article.color}'),
                      Text(
                        'Precio: \$${article.precio.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 24),
                      BlocSelector<ArticleDeleteCubit, ArticleDeleteState,
                          DeleteArticleStatus>(
                        selector: (state) => state.deleteArticleStatus,
                        builder: (context, state) {
                          final isLoading =
                              state == DeleteArticleStatus.loading;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (!isLoading) {
                                    Navigator.pop(context, false);
                                  }
                                },
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  cubit.deleteArticle(article.idArticulo);
                                },
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color:
                                            Color.fromARGB(255, 243, 170, 25),
                                      )
                                    : const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BlocSelector<ArticleDeleteCubit, ArticleDeleteState,
                    DeleteArticleStatus>(
                  selector: (state) => state.deleteArticleStatus,
                  builder: (s, c) {
                    if (c == DeleteArticleStatus.success) {
                      return GoodDialogBackground(
                        dialogType: DialogType.success,
                        dialogData: DialogData(
                          title: 'Elimación exitosa',
                          message: 'Elimación exitosa del artículo',
                          textButton: 'Cerrar',
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          barrierDismissible: false,
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
/* onCancel: context.pop,
              onDelete: () {
                articleCubit.deleteArticle(articleEntity.idArticulo);
              }, */




/**
 * 
 * BlocSelector<ArticleDeleteCubit, ArticleDeleteState,
                        DeleteArticleStatus>(
                      selector: (state) => state.deleteArticleStatus,
                      builder: (s, c) {
                        if (c == DeleteArticleStatus.loading) {
                          return const ColoredBox(
                            color: Color.fromARGB(90, 209, 209, 209),
                            child: DialogText(
                              text: 'Eliminando',
                            ),
                          );
                        } else if (c == DeleteArticleStatus.success) {
                          return ColoredBox(
                            color: const Color.fromARGB(90, 209, 209, 209),
                            child: DialogManagment.good(
                              dialogData: DialogData(
                                title: 'Elimación exitosa',
                                message: 'Elimación exitosa del artículo',
                                textButton: 'Cerrar',
                                onPressed: () {
                                  context.pop();
                                },
                                barrierDismissible: false,
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
 * 
 */