import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/article/cubit/article_cubit.dart';
import 'package:tanks_app/features/article/views/article_list_view.dart';
import 'package:tanks_app/injection/injection.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ArticleCubit>()),
      ],
      child: const ArticleListView(),
    );
  }
}
