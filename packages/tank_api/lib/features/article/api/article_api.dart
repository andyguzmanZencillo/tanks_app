import 'package:tank_api/features/article/article.dart';
import 'package:tank_api/features/company/api/company_api.dart';

class ArticleApi extends BaseApi {
  Future<String> saveArticle(
    InsertArticleRequest insertArticleRequest,
  ) async {
    try {
      final response = await post(
        insertArticleRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ArticleResponse>> getArticles(
    GetArticleRequest getArticleRequest,
  ) async {
    try {
      final response = await post(
        getArticleRequest.toJson(),
      );
      final list = response.resultSp as List;
      return list
          .map(
            (e) => ArticleResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteArticle(
    DeleteArticleRequest deletehUserRequest,
  ) async {
    try {
      final response = await post(
        deletehUserRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateArticle(
    UpdateArticleRequest updateArticleRequest,
  ) async {
    try {
      final response = await post(
        updateArticleRequest.toJson(),
      );
      return response.message;
    } catch (e) {
      rethrow;
    }
  }
}
