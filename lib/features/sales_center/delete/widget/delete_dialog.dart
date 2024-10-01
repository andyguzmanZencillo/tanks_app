import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/sales_center/delete/cubit/delete_sales_center_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class DeleteSalesCenterDialog extends StatelessWidget {
  const DeleteSalesCenterDialog({
    required this.salesCenterEntity,
    super.key,
  });
  final SalesCenterEntity salesCenterEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DeleteSalesCenterCubit>(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<DeleteSalesCenterCubit>();
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
                        'Nombre: ${salesCenterEntity.centroVenta}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Descripción: ${salesCenterEntity.descripcion}'),
                      const SizedBox(height: 24),
                      BlocSelector<DeleteSalesCenterCubit,
                          DeleteSalesCenterState, DeleteStatus>(
                        selector: (state) => state.deleteStatus,
                        builder: (context, state) {
                          final isLoading = state == DeleteStatus.loading;
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
                                  cubit.delete(salesCenterEntity.idCentroVenta);
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
                BlocSelector<DeleteSalesCenterCubit, DeleteSalesCenterState,
                    DeleteStatus>(
                  selector: (state) => state.deleteStatus,
                  builder: (s, c) {
                    if (c == DeleteStatus.success) {
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