import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/cubit/article_cubit.dart';
import 'package:tanks_app/features/article/views/article_list_body.dart';

class ArticleListView extends StatelessWidget {
  const ArticleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ListenerPro<ArticleCubit, ArticleState>().listen(
          onPressedSuccess: () {
            context.pop();
            context.read<ArticleCubit>().getArticles();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<ArticleCubit>().getArticles();
        },
        child: const ArticleListBody(),
      ),
    );
  }
}
