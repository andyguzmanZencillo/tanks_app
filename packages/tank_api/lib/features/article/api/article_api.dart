import 'package:tank_api/features/article/models/article_request.dart';
import 'package:tank_api/features/company/api/company_api.dart';

class ArticleApi extends BaseApi {
  Future<String> saveArticle(
    InsertArticleRequest insertArticleRequest,
  ) async {
    try {
      final response = await post(
        insertArticleRequest.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ArticleRequest>> getArticles(
    GetArticleRequest getArticleRequest,
  ) async {
    try {
      final response = await post(
        getArticleRequest.toJson(),
      );
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteArticle(
    DeletehArticleRequest deletehUserRequest,
  ) async {
    try {
      final response = await post(
        deletehUserRequest.toJson(),
      );
      return response;
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
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
