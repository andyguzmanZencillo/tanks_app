import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:pos_database/pos_database.dart';
import 'package:tank_api/tank_api.dart';
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
      final user = await _userDatabase.getUser();
      final request = GetArticleRequest(
        idCompania: user.idCompany,
      );
      final response = await _api.getArticles(request);
      return [];
    });
  }
}
