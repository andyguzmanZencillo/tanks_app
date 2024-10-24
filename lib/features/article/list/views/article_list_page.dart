import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/article/delete/cubit/article_delete_cubit.dart';
import 'package:tanks_app/features/article/list/cubit/article_list_cubit.dart';
import 'package:tanks_app/features/article/list/views/article_list_view.dart';
import 'package:tanks_app/injection/injection.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => const ArticleListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ArticleListCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ArticleDeleteCubit>(),
        ),
      ],
      child: const ArticleListView(),
    );
  }
}
