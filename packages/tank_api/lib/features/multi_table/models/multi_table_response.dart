import 'package:tank_api/core/extends/json_extends.dart';
import 'package:tank_api/features/article/article.dart';
import 'package:tank_api/features/console/models/console_response.dart';
import 'package:tank_api/features/sales_center/models/sales_center_response.dart';

class MultiTableResponse {
  MultiTableResponse({
    required this.articles,
    required this.salesCenter,
    required this.consoles,
  });

  factory MultiTableResponse.fromJson(Map<String, dynamic> json) {
    final articlesMap = json.get<List<dynamic>>('articulo', []);
    final salesCenterMap = json.get<List<dynamic>>('centro_venta', []);
    final consolesMap = json.get<List<dynamic>>('consola_tanque', []);
    return MultiTableResponse(
      articles: articlesMap
          .map((e) => ArticleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      salesCenter: salesCenterMap
          .map((e) => SalesCenterResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      consoles: consolesMap
          .map((e) => ConsoleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  final List<ArticleResponse> articles;
  final List<SalesCenterResponse> salesCenter;
  final List<ConsoleResponse> consoles;
}
