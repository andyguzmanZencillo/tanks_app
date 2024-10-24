import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this.articleRepository) : super(const ArticleListState());

  final ArticleRepository articleRepository;

  void onChangeSelected(ArticleEntity selected) {
    emit(state.copyWith(selected: selected));
  }

  Future<bool> getArticles() async {
    emit(state.copyWith(generalStatus: GeneralStatus.loading));
    final result = await articleRepository.getArticles();
    result.when(
      ok: (ok) {
        emit(
          state.copyWith(
            list: ok,
            listCopy: ok,
            generalStatus: GeneralStatus.success,
          ),
        );
      },
      err: (err) {
        emit(
          state.copyWith(
            list: [],
            generalStatus: GeneralStatus.error,
          ),
        );
      },
    );
    return result.isOk();
  }

  void search(String text) {
    final listCopy = [...state.listCopy];
    final listSearh = listCopy
        .where(
          (element) =>
              element.articulo.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();

    emit(state.copyWith(list: listSearh));
  }
}
