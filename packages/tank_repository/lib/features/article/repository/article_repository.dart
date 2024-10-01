import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/tank_api.dart';
import 'package:tank_database/tank_database.dart';
import 'package:tank_repository/core/generic_token.dart';
import 'package:tank_repository/features/article/article.dart';

class ArticleRepository {
  ArticleRepository({
    ArticleApi? api,
    UserDatabase? userDatabase,
  })  : _userDatabase = userDatabase ?? UserDatabase(),
        _api = api ?? ArticleApi();

  final ArticleApi _api;
  final UserDatabase _userDatabase;

  Future<Result<List<ArticleEntity>, Failure>> getArticles() {
    return handleExceptionCompleteToken<List<ArticleEntity>>(() async {
      //final user = await _userDatabase.getUser();
      final request = GetArticleRequest(
        idCompania: 1,
      );
      final response = await _api.getArticles(request);
      return response.map((e) => e.toEntity()).toList();
    });
  }

  Future<Result<bool, Failure>> saveArticle(ArticleEntity articleEntity) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = InsertArticleRequest(
        idCompania: 1,
        articulo: articleEntity.articulo,
        descripcion: articleEntity.descripcion,
        codigoArticulo: articleEntity.code,
        color: articleEntity.color,
        precio: articleEntity.precio,
      );
      final response = await _api.saveArticle(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> updateArticle(ArticleEntity articleEntity) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = UpdateArticleRequest(
        idArticulo: articleEntity.idArticulo,
        idCompania: 1,
        articulo: articleEntity.articulo,
        descripcion: articleEntity.descripcion,
        codigoArticulo: articleEntity.code,
        color: articleEntity.color,
        precio: articleEntity.precio,
      );
      final response = await _api.updateArticle(request);
      return true;
    });
  }

  Future<Result<bool, Failure>> deleteArticle(int idArticle) {
    return handleExceptionCompleteToken<bool>(() async {
      //final user = await _userDatabase.getUser();
      final request = DeleteArticleRequest(
        idArticle: idArticle,
        idCompania: 1,
      );
      final response = await _api.deleteArticle(request);
      return true;
    });
  }
}
