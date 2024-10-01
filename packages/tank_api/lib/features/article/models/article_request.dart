import 'package:tank_api/features/company/models/company_request.dart';

class ArticleRequest extends RequestBase {
  ArticleRequest({
    super.query = 'FNZSTanques_crud_articulo',
  });
}

class InsertArticleRequest extends ArticleRequest {
  InsertArticleRequest({
    required this.idCompania,
    required this.articulo,
    required this.descripcion,
    required this.codigoArticulo,
    required this.color,
    required this.precio,
    this.idUserTrace = 123,
    this.operation = 'I',
  });

  final int idUserTrace;
  final String operation;
  final int idCompania;
  final String articulo;
  final String descripcion;

  final String codigoArticulo;
  final String color;
  final double precio;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'articulo': articulo,
      'descripcion': descripcion,
      'codigo_articulo': codigoArticulo,
      'color': color,
      'precio': precio,
    });
  }
}

class UpdateArticleRequest extends ArticleRequest {
  UpdateArticleRequest({
    required this.idCompania,
    required this.idArticulo,
    required this.articulo,
    required this.descripcion,
    required this.codigoArticulo,
    required this.color,
    required this.precio,
    this.idUserTrace = 123,
    this.operation = 'U',
  });

  final int idUserTrace;
  final int idArticulo;
  final String operation;
  final int idCompania;
  final String articulo;
  final String descripcion;

  final String codigoArticulo;
  final String color;
  final double precio;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
      'id_articulo': idArticulo,
      'articulo': articulo,
      'descripcion': descripcion,
      'codigo_articulo': codigoArticulo,
      'color': color,
      'precio': precio,
    });
  }
}

class GetArticleRequest extends ArticleRequest {
  GetArticleRequest({
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'S',
  });

  final int idUserTrace;
  final String operation;

  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_compania': idCompania,
    });
  }
}

class DeleteArticleRequest extends ArticleRequest {
  DeleteArticleRequest({
    required this.idArticle,
    required this.idCompania,
    this.idUserTrace = 123,
    this.operation = 'D',
  });
  final int idUserTrace;
  final String operation;
  final int idArticle;
  final int idCompania;

  Map<String, dynamic> toJson() {
    return super.toJsonParams({
      'id_user_trace': idUserTrace,
      'operation': operation,
      'id_articulo': idArticle,
      'id_compania': idCompania,
    });
  }
}
