import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/formaters/formaters.dart';
import 'package:tanks_app/core/util/validator_field/valid.dart';
import 'package:tanks_app/core/util/validator_field/validator_field.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/create_update/cubit/create_update_cubit.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';
import 'package:tanks_app/injection/injection.dart';

class CreateUpdatePage extends StatelessWidget {
  const CreateUpdatePage({
    required this.typeOperation,
    this.articleEntity = const ArticleEntity.empty(),
    super.key,
  });
  final TypeOperation typeOperation;
  final ArticleEntity articleEntity;

  static Route<bool?> route({
    required TypeOperation typeOperation,
    ArticleEntity articleEntity = const ArticleEntity.empty(),
  }) {
    return MaterialPageRoute<bool?>(
      builder: (context) => CreateUpdatePage(
        typeOperation: typeOperation,
        articleEntity: articleEntity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CreateUpdateInherited(
      typeOperation: typeOperation,
      articleEntity: articleEntity,
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
    final dialog = context.read<DialogHandlerCubit>();
    final inherited = CreateUpdateInherited.of(context);
    return BlocListener<CreateUpdateCubit, CreateUpdateState>(
      listener: (context, state) {
        final s = state.articleStatus;
        if (s == UpsertStatus.loading) {
          if (inherited.typeOperation == TypeOperation.create) {
            dialog.onOpenNotification(
              message: 'Creando Artículo...',
              dialogType: DialogType.loading,
            );
          } else {
            dialog.onOpenNotification(
              message: 'Actualizando Artículo...',
              dialogType: DialogType.loading,
            );
          }
        } else if (s == UpsertStatus.error) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: inherited.typeOperation == TypeOperation.create
                  ? 'Error al crear artículo'
                  : 'Error al actualizar artículo',
              title: 'Error',
              onPressed: () {
                context.pop();
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.error,
          );
        } else if (s == UpsertStatus.success) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: inherited.typeOperation == TypeOperation.create
                  ? 'Artículo creado exitosamente'
                  : 'Artículo actualizado exitosamente',
              title: inherited.typeOperation == TypeOperation.create
                  ? 'Creación exitosa'
                  : 'Actualización exitosa',
              onPressed: () {
                context.pop();
                Navigator.pop(context, true);
              },
              textButton: 'Cerrar',
            ),
            dialogType: DialogType.success,
          );
        }
      },
      child: const CreateUpdateBody(),
    );
  }
}

class CreateUpdateBody extends StatelessWidget {
  const CreateUpdateBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = CreateUpdateInherited.of(context);
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
                                ? 'Creación de un artículo'
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
                          //color: Color.fromARGB(52, 29, 29, 29),
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
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                labelSingle: false,
                                controller: inherited.nameArticle,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo nombre artículo requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Nombre Artículo',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                controller: inherited.description,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error:
                                          'Campo del ID compañia requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Descripción',
                                labelSingle: false,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                controller: inherited.codeArticle,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error:
                                          'Campo del ID compañia requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Codigo Artículo',
                                labelSingle: false,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                controller: inherited.color,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error:
                                          'Campo del ID compañia requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Color',
                                labelSingle: false,
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.factory),
                                controller: inherited.price,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error:
                                          'Campo del ID compañia requerido...',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Precio',
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
                                labelSingle: false,
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
                                    } else {
                                      cubit.updateArticle(
                                        articleEntity: inherited.articleEntity,
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
                                    ? 'Crear Artículo'
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
