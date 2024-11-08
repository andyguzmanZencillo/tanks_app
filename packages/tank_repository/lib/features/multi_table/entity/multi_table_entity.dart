import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tank_repository/features/console/entity/console_entity.dart';
import 'package:tank_repository/features/sales_center/entity/sales_center_entity.dart';

class MultiTableEntity {
  MultiTableEntity({
    required this.articles,
    required this.salesCenter,
    required this.consoles,
  });

  final List<ArticleEntity> articles;
  final List<SalesCenterEntity> salesCenter;
  final List<ConsoleEntity> consoles;
}
