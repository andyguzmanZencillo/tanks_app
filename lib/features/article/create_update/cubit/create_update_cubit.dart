import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tank_repository/features/article/repository/article_repository.dart';
import 'package:tanks_app/core/util/enums/enums.dart';

part 'create_update_state.dart';

class CreateUpdateCubit extends Cubit<CreateUpdateState> {
  CreateUpdateCubit(this.articleRepository) : super(const CreateUpdateState());
  final ArticleRepository articleRepository;

  Future<void> createArticle({
    required String name,
    required String description,
    required String code,
    required String color,
    required String price,
  }) async {
    emit(state.copyWith(articleStatus: UpsertStatus.loading));
    final result = await articleRepository.saveArticle(
      ArticleEntity(
        idArticulo: 0,
        articulo: name,
        descripcion: description,
        color: color,
        precio: double.parse(price),
        code: code,
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(articleStatus: UpsertStatus.success));
      },
      err: (err) {
        emit(state.copyWith(articleStatus: UpsertStatus.error));
      },
    );
  }

  Future<void> updateArticle({
    required ArticleEntity articleEntity,
    required String name,
    required String description,
    required String code,
    required String color,
    required String price,
  }) async {
    emit(state.copyWith(articleStatus: UpsertStatus.loading));
    final result = await articleRepository.updateArticle(
      articleEntity.copyWith(
        articulo: name,
        descripcion: description,
        color: color,
        precio: double.parse(price),
        code: code,
      ),
    );

    result.when(
      ok: (ok) {
        emit(state.copyWith(articleStatus: UpsertStatus.success));
      },
      err: (err) {
        emit(state.copyWith(articleStatus: UpsertStatus.error));
      },
    );
  }
}
