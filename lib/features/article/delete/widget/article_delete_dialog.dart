import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/features/article/delete/cubit/article_delete_cubit.dart';
import 'package:tanks_app/features/article/list/cubit/article_list_cubit.dart';

class ArticleDeleteDialog extends StatelessWidget {
  const ArticleDeleteDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArticleDeleteCubit>();
    final articleListCubit = context.read<ArticleListCubit>();
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Confirmar Eliminación',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Text(
              '¿Estás seguro de que deseas eliminar el siguiente artículo?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Nombre: ${articleListCubit.state.selected.articulo}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Descripción: ${articleListCubit.state.selected.descripcion}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            BlocSelector<ArticleDeleteCubit, ArticleDeleteState, DeleteStatus>(
              selector: (state) => state.deleteStatus,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ButtonCustom(
                        backgroundColor:
                            const Color.fromARGB(255, 194, 194, 194),
                        onPressed: () {
                          context.pop();
                        },
                        text: 'Cancelar',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonCustom(
                        backgroundColor: Colors.red,
                        onPressed: () {
                          cubit.deleteArticle(
                            articleListCubit.state.selected.idArticulo,
                          );
                          context.pop();
                        },
                        text: 'Eliminar',
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
