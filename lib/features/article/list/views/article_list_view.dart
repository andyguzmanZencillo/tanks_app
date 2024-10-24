import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/delete/helpers/article_delete_listener.dart';
import 'package:tanks_app/features/article/list/cubit/article_list_cubit.dart';
import 'package:tanks_app/features/article/list/helpers/list_article_listener.dart';
import 'package:tanks_app/features/article/list/views/article_list_body.dart';

class ArticleListView extends StatelessWidget {
  const ArticleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ArticleListListener.article(),
        ArticleDeleteListener.article(
          onTap: () {
            context.read<ArticleListCubit>().getArticles();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<ArticleListCubit>().getArticles();
        },
        onDispose: () {},
        child: const ArticleListBody(),
      ),
    );
  }
}
