import 'package:flutter/material.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';

enum TypeOperation {
  create,
  update,
  normal,
  sincronization,
  sincronizactionsale,
  about,
}

class CreateUpdateInherited extends InheritedWidget {
  CreateUpdateInherited({
    required super.child,
    required this.typeOperation,
    this.articleEntity = const ArticleEntity.empty(),
    super.key,
  }) {
    if (typeOperation == TypeOperation.update) {
      nameArticle.textEditingController.text = articleEntity.articulo;
      description.textEditingController.text = articleEntity.descripcion;
      codeArticle.textEditingController.text = articleEntity.code;
      color.textEditingController.text = articleEntity.color;
      price.textEditingController.text = articleEntity.precio.toString();
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;
  final ArticleEntity articleEntity;

  final nameArticle = ControllerField();
  final description = ControllerField();
  final codeArticle = ControllerField();
  final color = ControllerField();
  final price = ControllerField();
  final formKey = GlobalKey<FormState>();

  static CreateUpdateInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<CreateUpdateInherited>();
    assert(result != null, 'No LicenseFormInherited found in context');
    return result!;
  }

  void dispose() {
    nameArticle.dispose();
    description.dispose();
    codeArticle.dispose();
    color.dispose();
    price.dispose();
  }

  void clear() {
    nameArticle.textEditingController.clear();
    description.textEditingController.clear();
    codeArticle.textEditingController.clear();
    color.textEditingController.clear();
    price.textEditingController.clear();
  }

  ResultValidate valid() {
    return formKey.validateAndGetErrors([
      nameArticle.fieldKey,
      description.fieldKey,
      codeArticle.fieldKey,
      color.fieldKey,
      price.fieldKey,
    ]);
  }
}
