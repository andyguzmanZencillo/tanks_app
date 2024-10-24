import 'package:flutter/widgets.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

class CreateArticleFormInherited extends InheritedWidget {
  CreateArticleFormInherited({
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
  final formKey = GlobalKey<FormState>();
  final descriptionCompany = ControllerField();

  static CreateArticleFormInherited of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<CreateArticleFormInherited>();
    assert(result != null, 'No CreateArticleFormInherited found in context');
    return result!;
  }

  void dispose() {
    descriptionCompany.textEditingController.dispose();
  }

  ResultValidate isValid() {
    return formKey.validateAndGetErrors([descriptionCompany.fieldKey]);
  }

  void clear() {
    descriptionCompany.textEditingController.clear();
  }
}
