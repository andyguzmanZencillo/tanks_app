import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/color_picker_text_field_pro.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';
import 'package:tanks_app/features/article/cubit/article_cubit.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/article/helpers/extend_fields_article.dart';

class CreateUpdatePage extends StatelessWidget {
  const CreateUpdatePage({
    required this.typeOperation,
    super.key,
  });
  final TypeOperation typeOperation;

  @override
  Widget build(BuildContext context) {
    return UpsertArticleInherited(
      typeOperation: typeOperation,
      child: const CreateUpdateView(),
    );
  }
}

class CreateUpdateView extends StatelessWidget {
  const CreateUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final articleListCubit = context.read<ArticleCubit>();
    final inherited = UpsertArticleInherited.of(context);
    return FullWidgetGeneric(
      onInit: () {
        if (inherited.typeOperation == TypeOperation.update) {
          inherited.setData(articleListCubit.state.selected);
        }
      },
      onDispose: () {},
      child: const CreateUpdateBody(),
    );
  }
}

class CreateUpdateBody extends StatelessWidget {
  const CreateUpdateBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertArticleInherited.of(context);
    final articleCubit = context.read<ArticleCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          inherited.typeOperation == TypeOperation.create
              ? 'Nuevo artículo'
              : 'Modificar artículo',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 16, 16, 34),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: inherited.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*TextFieldCustomNew(
                      controller: inherited.nameArticle,
                      label: 'Nombre Artículo',
                      title: 'Nombre Artículo',
                      maxLength: 35,
                    ),*/
                    TextFieldPro(
                      extendTextField: ExtendFieldsArticle.nameArticle,
                      controller: inherited.nameArticle,
                    ),
                    TextFieldPro(
                      extendTextField: ExtendFieldsArticle.description,
                      controller: inherited.description,
                    ),
                    TextFieldPro(
                      extendTextField: ExtendFieldsArticle.codeArticle,
                      controller: inherited.codeArticle,
                    ),
                    ColorPickerTextFieldPro(
                      controller: inherited.color,
                    ),
                    TextFieldPro(
                      extendTextField: ExtendFieldsArticle.price,
                      controller: inherited.price,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonCustom(
                            backgroundColor: Colors.red,
                            onPressed: () {
                              context.pop();
                            },
                            text: 'Cancelar',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonCustom(
                            onPressed: () {
                              final validResult = inherited.valid();
                              if (validResult.isPassed) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (inherited.typeOperation ==
                                    TypeOperation.create) {
                                  articleCubit.createArticle(
                                    name: inherited.nameArticle.getValue(),
                                    description:
                                        inherited.description.getValue(),
                                    code: inherited.codeArticle.getValue(),
                                    color: inherited.color.getValue(),
                                    price: inherited.price.getValue(),
                                  );
                                } else {
                                  articleCubit.updateArticle(
                                    articleEntity: articleCubit.state.selected,
                                    name: inherited
                                        .nameArticle.textEditingController.text,
                                    description: inherited
                                        .description.textEditingController.text,
                                    code: inherited
                                        .codeArticle.textEditingController.text,
                                    color: inherited
                                        .color.textEditingController.text,
                                    price: inherited
                                        .price.textEditingController.text,
                                  );
                                }
                              }
                            },
                            text:
                                inherited.typeOperation == TypeOperation.create
                                    ? 'Registrar'
                                    : 'Actualizar',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
