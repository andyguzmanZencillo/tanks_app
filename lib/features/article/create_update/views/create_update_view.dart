import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/colo_picker_text_field.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/create_update/cubit/create_update_cubit.dart';
import 'package:tanks_app/features/article/create_update/helpers/upsert_article_listener.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/list/cubit/article_list_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

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
      child: BlocProvider(
        create: (context) => sl<CreateUpdateCubit>(),
        child: const CreateUpdateView(),
      ),
    );
  }
}

class CreateUpdateView extends StatelessWidget {
  const CreateUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final articleListCubit = context.read<ArticleListCubit>();
    final inherited = UpsertArticleInherited.of(context);
    return MultiBlocListener(
      listeners: [
        UpsertArticleListener.article(),
        UpsertArticleListener.event(
          success: () {
            context.read<ArticleListCubit>().getArticles();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          if (inherited.typeOperation == TypeOperation.update) {
            inherited.setData(articleListCubit.state.selected);
          }
        },
        onDispose: () {},
        child: const CreateUpdateBody(),
      ),
    );
  }
}

class CreateUpdateBody extends StatelessWidget {
  const CreateUpdateBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertArticleInherited.of(context);
    final listArticleCubit = context.read<ArticleListCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: BlocContext<CreateUpdateCubit, CreateUpdateState>(
        builder: (context, cubit) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            inherited.typeOperation == TypeOperation.create
                                ? 'Registro de un artículo'
                                : 'Actualización de artículo',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Form(
                          key: inherited.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFieldCustomPro(
                                controller: inherited.nameArticle,
                                label: 'Nombre Artículo',
                              ),
                              TextFieldCustomPro(
                                controller: inherited.description,
                                label: 'Descripción',
                              ),
                              TextFieldCustomPro(
                                controller: inherited.codeArticle,
                                label: 'Codigo Artículo',
                              ),
                              ColorPickerTextField(
                                controller: inherited.color,
                              ),
                              TextFieldCustomPro(
                                controller: inherited.price,
                                label: 'Precio',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ButtonCustom(
                                onPressed: () {
                                  final validResult = inherited.valid();
                                  if (validResult.isPassed) {
                                    if (inherited.typeOperation ==
                                        TypeOperation.create) {
                                      cubit.createArticle(
                                        name: inherited.nameArticle.getValue(),
                                        description:
                                            inherited.description.getValue(),
                                        code: inherited.codeArticle.getValue(),
                                        color: inherited.color.getValue(),
                                        price: inherited.price.getValue(),
                                      );
                                    } else {
                                      cubit.updateArticle(
                                        articleEntity:
                                            listArticleCubit.state.selected,
                                        name: inherited.nameArticle
                                            .textEditingController.text,
                                        description: inherited.description
                                            .textEditingController.text,
                                        code: inherited.codeArticle
                                            .textEditingController.text,
                                        color: inherited
                                            .color.textEditingController.text,
                                        price: inherited
                                            .price.textEditingController.text,
                                      );
                                    }
                                  }
                                },
                                text: inherited.typeOperation ==
                                        TypeOperation.create
                                    ? 'Registrar Artículo'
                                    : 'Actualizar Artículo',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
