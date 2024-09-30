import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: Scaffold(
        body: BlocBuilder<ArticleCubit, ArticleState>(
          builder: (context, state) {
            return const Column();
          },
        ),
      ),
    );
  }
}
