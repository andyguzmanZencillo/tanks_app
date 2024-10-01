import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_view.dart';
import 'package:tanks_app/features/article/delete/widget/delete_dialog.dart';
import 'package:tanks_app/features/article/list/cubit/article_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => const ArticleList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ArticleCubit>()..getArticles(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Articulos'),
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /*SearchWidget(
                    searchController: TextEditingController(),
                    onSearch: () {},
                  ),*/
                  ElevatedButton(
                    onPressed: () {
                      context
                          .pushResult<bool?>(
                        CreateUpdatePage.route(
                          typeOperation: TypeOperation.create,
                        ),
                      )
                          .then((value) {
                        if (value == null || value == false) {
                          return;
                        }
                        context.read<ArticleCubit>().getArticles();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 170, 25),
                      padding: const EdgeInsets.symmetric(
                        //vertical: 15,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Crear Articulo',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: BlocBuilder<ArticleCubit, ArticleState>(
                      builder: (context, state) {
                        final list = state.articles;
                        return list.toListView(
                          itemSpacing: 10,
                          itemBuilder: (context, item, index) {
                            return ItemArticle(
                              articleEntity: item,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemArticle extends StatelessWidget {
  const ItemArticle({required this.articleEntity, super.key});
  final ArticleEntity articleEntity;

  @override
  Widget build(BuildContext context) {
    void actionPopUpItemSelected(String value, ArticleEntity articleEntity) {
      if (value == 'edit') {
        context.push(
          CreateUpdatePage.route(
            typeOperation: TypeOperation.update,
            articleEntity: articleEntity,
          ),
        );
      } else if (value == 'delete') {
        showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return DeleteDialog(
              article: articleEntity,
            );
          },
        ).then((value) {
          if (value == null || value == false) {
            return;
          }
          context.read<ArticleCubit>().getArticles();
        });
      } else {}
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 243, 170, 25),
          child: Icon(
            Icons.art_track,
            color: Colors.white,
          ),
        ),
        title: Text(articleEntity.articulo),
        subtitle: Text(
          '${articleEntity.descripcion}\nColor: ${articleEntity.color}\nPrecio: \$${articleEntity.precio.toStringAsFixed(2)}',
        ),
        isThreeLine: true,
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Editar'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Eliminar'),
              ),
            ];
          },
          onSelected: (v) => actionPopUpItemSelected(v, articleEntity),
        ),
      ),
    );
  }
}
