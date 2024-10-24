import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/form/validator_field/valid.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';

enum TypeOperation {
  create,
  update,
  normal,
  sincronization,
  sincronizactionsale,
  about,
}

class UpsertArticleInherited extends InheritedWidget {
  UpsertArticleInherited({
    required super.child,
    required this.typeOperation,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  final TypeOperation typeOperation;

  final nameArticle = ControllerField(
    validators: [
      RequiredValid(
        error: 'Campo nombre artículo requerido',
      ),
    ],
  );

  final description = ControllerField(
    validators: [
      RequiredValid(
        error: 'Campo descripción requerida',
      ),
    ],
  );

  final codeArticle = ControllerField(
    validators: [
      RequiredValid(
        error: 'Campo código artículo requerido',
      ),
    ],
  );

  final color = ControllerField(
    validators: [
      RequiredValid(
        error: 'Campo color requerido',
      ),
    ],
  );

  final price = ControllerField(
    validators: [
      RequiredValid(
        error: 'Campo precio requerido',
      ),
    ],
    inputFormatters: [
      //FilteringTextInputFormatter.digitsOnly,
      DecimalTextInputFormatter(decimalRange: 3),
      FilteringTextInputFormatter.allow(
        RegExp(r'^\d+\.?\d{0,3}'),
      ),
      FilteringTextInputFormatter.deny(
        RegExp(r'\s'),
      ),
    ],
  );

  final formKey = GlobalKey<FormState>();

  static UpsertArticleInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<UpsertArticleInherited>();
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

  void setData(ArticleEntity articleEntity) {
    nameArticle.setValue(articleEntity.articulo);
    description.setValue(articleEntity.descripcion);
    codeArticle.setValue(articleEntity.code);
    color.setValue(articleEntity.color);
    price.setValue(articleEntity.precio.toString());
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
