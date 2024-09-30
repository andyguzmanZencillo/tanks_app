import 'package:tank_api/tank_api.dart';
import 'package:tank_repository/features/article/article.dart';

extension ArticleResponseToEntity on ArticleResponse {
  ArticleEntity toEntity() {
    return ArticleEntity(
      idArticulo: idArticulo,
      articulo: articulo,
      descripcion: descripcion,
      color: color,
      precio: precio,
    );
  }
}
