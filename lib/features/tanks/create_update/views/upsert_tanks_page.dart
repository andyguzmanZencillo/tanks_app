import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/validator_field/valid.dart';
import 'package:tanks_app/core/util/validator_field/validator_field.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/list/cubit/article_cubit.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';
import 'package:tanks_app/features/tanks/create_update/cubit/upsert_tanks_cubit.dart';
import 'package:tanks_app/features/tanks/create_update/views/upsert_tanks_inherited.dart';
import 'package:tanks_app/features/tanks/create_update/widgets/dropdown.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertTanksPage extends StatelessWidget {
  const UpsertTanksPage({
    required this.typeOperation,
    this.consoleEntity = const TanksEntity.empty(),
    super.key,
  });
  final TypeOperation typeOperation;
  final TanksEntity consoleEntity;

  static Route<bool?> route({
    required TypeOperation typeOperation,
    TanksEntity consoleEntity = const TanksEntity.empty(),
  }) {
    return MaterialPageRoute<bool?>(
      builder: (context) => UpsertTanksPage(
        typeOperation: typeOperation,
        consoleEntity: consoleEntity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UpsertTanksInherited(
      typeOperation: typeOperation,
      tanksEntity: consoleEntity,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<UpsertTanksCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<SalesCenterCubit>()..getAll(),
          ),
          BlocProvider(
            create: (context) => sl<ConsoleCubit>()..getAll(),
          ),
          BlocProvider(
            create: (context) => sl<ArticleCubit>()..getArticles(),
          ),
        ],
        child: const UpsertTanksView(),
      ),
    );
  }
}

class UpsertTanksView extends StatelessWidget {
  const UpsertTanksView({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = context.read<DialogHandlerCubit>();
    final inherited = UpsertTanksInherited.of(context);
    return BlocListener<UpsertTanksCubit, UpsertTanksState>(
      listener: (context, state) {
        final s = state.upsertStatus;
        if (s == UpsertStatus.loading) {
          if (inherited.typeOperation == TypeOperation.create) {
            dialog.onOpenNotification(
              message: 'Creando tanques',
              dialogType: DialogType.loading,
            );
          } else {
            dialog.onOpenNotification(
              message: 'Actualizando tanques',
              dialogType: DialogType.loading,
            );
          }
        } else if (s == UpsertStatus.error) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: inherited.typeOperation == TypeOperation.create
                  ? state.errorMessage ?? 'Error al crear tanques'
                  : state.errorMessage ?? 'Error al actualizar tanques',
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
                  ? 'Tanque creado exitosamente'
                  : 'Tanque actualizado exitosamente',
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
      child: const UpsertTanksBody(),
    );
  }
}

class UpsertTanksBody extends StatelessWidget {
  const UpsertTanksBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertTanksInherited.of(context);

    final isCreate = inherited.typeOperation == TypeOperation.create;
    final isUpdate = inherited.typeOperation == TypeOperation.update;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: BlocContext<UpsertTanksCubit, UpsertTanksState>(
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
                                ? 'Creación de un tanque'
                                : 'Actualización de un tanque',
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
                              BlocSelector<SalesCenterCubit, SalesCenterState,
                                  List<SalesCenterEntity>>(
                                selector: (state) {
                                  return state.salesCenters;
                                },
                                builder: (context, state) {
                                  if (state.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  SalesCenterEntity? itemDefault;

                                  if (isUpdate) {
                                    itemDefault = state.firstWhereOrNull(
                                      (element) =>
                                          element.idCentroVenta ==
                                          inherited.tanksEntity.idCentroVenta,
                                    );
                                  }

                                  return DropdownCustom(
                                    controller: inherited.saleCenter,
                                    validator: (p0) {
                                      if (p0 == null) {
                                        return 'Valor requerido';
                                      }
                                      return null;
                                    },
                                    label: 'Centro de venta',
                                    value: itemDefault,
                                    showDecoration: false,
                                    isLabelTitle: true,
                                    items: state,
                                  );
                                },
                              ),
                              BlocSelector<ArticleCubit, ArticleState,
                                  List<ArticleEntity>>(
                                selector: (state) {
                                  return state.articles;
                                },
                                builder: (context, state) {
                                  if (state.isEmpty) {
                                    return const SizedBox.shrink();
                                  }

                                  ArticleEntity? articleEntity;

                                  if (isUpdate) {
                                    articleEntity = state.firstWhereOrNull(
                                      (element) =>
                                          element.idArticulo ==
                                          inherited.tanksEntity.idArticulo,
                                    );
                                  }
                                  return DropdownCustom(
                                    controller: inherited.article,
                                    validator: (p0) {
                                      if (p0 == null) {
                                        return 'Valor requerido';
                                      }
                                      return null;
                                    },
                                    label: 'Articulos',
                                    value: articleEntity,
                                    showDecoration: false,
                                    isLabelTitle: true,
                                    items: state,
                                  );
                                },
                              ),
                              BlocSelector<ConsoleCubit, ConsoleState,
                                  List<ConsoleEntity>>(
                                selector: (state) {
                                  return state.consoles;
                                },
                                builder: (context, state) {
                                  if (state.isEmpty) {
                                    return const SizedBox.shrink();
                                  }

                                  ConsoleEntity? consoleEntity;

                                  if (isUpdate) {
                                    consoleEntity = state.firstWhereOrNull(
                                      (element) =>
                                          element.idConsola ==
                                          inherited.tanksEntity.idConsolaTanque,
                                    );
                                  }

                                  return DropdownCustom(
                                    controller: inherited.console,
                                    validator: (p0) {
                                      if (p0 == null) {
                                        return 'Valor requerido';
                                      }
                                      return null;
                                    },
                                    label: 'Consolas de tanque',
                                    value: consoleEntity,
                                    showDecoration: false,
                                    isLabelTitle: true,
                                    items: state,
                                  );
                                },
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.scale),
                                labelSingle: false,
                                controller: inherited
                                    .capacidadField, // Cambiar a capacidadField
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Capacidad requerido',
                                    ),
                                  ],
                                ),
                                label: 'Capacidad',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.height),
                                labelSingle: false,
                                controller: inherited
                                    .alturaTanqueField, // Cambiar a alturaTanqueField
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Altura Tanque requerido',
                                    ),
                                  ],
                                ),
                                label: 'Altura Tanque',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.description),
                                labelSingle: false,
                                controller:
                                    inherited.descripcionField, // Mantener
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Descripción requerido',
                                    ),
                                  ],
                                ),
                                label: 'Descripción',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.percent),
                                labelSingle: false,
                                controller: inherited
                                    .porcentajeMinimoCombustibleField, // Cambiar a porcentajeMinimoCombustibleField
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error:
                                          'Campo Porcentaje Mínimo Combustible requerido',
                                    ),
                                  ],
                                ),
                                label: 'Porcentaje Mínimo Combustible',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.height),
                                labelSingle: false,
                                controller: inherited
                                    .alturaOffsetField, // Cambiar a alturaOffsetField
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Altura Offset requerido',
                                    ),
                                  ],
                                ),
                                label: 'Altura Offset',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ButtonCustom(
                                onPressed: () {
                                  final validResult = inherited.valid();
                                  if (validResult.isPassed) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    if (inherited.typeOperation ==
                                        TypeOperation.create) {
                                      cubit.create(
                                        idCentroVenta: inherited.saleCenter.id,
                                        idArticulo: inherited.article.id,
                                        capacidad:
                                            inherited.capacidadField.getValue(),
                                        alturaTanque: inherited
                                            .alturaTanqueField
                                            .getValue(),
                                        descripcion: inherited.descripcionField
                                            .getValue(),
                                        porcentajeMinimoCombustible: inherited
                                            .porcentajeMinimoCombustibleField
                                            .getValue(),
                                        alturaOffset: inherited
                                            .alturaOffsetField
                                            .getValue(),
                                        factorInicioDescargue: '0',
                                        codigo: '0',
                                        alturaAguaOffset: 0,
                                        offsetInclinacion: 0,
                                        estado: true,
                                        modificable: false,
                                        manejaMm: false,
                                        idConsolaTanque: inherited.console.id,
                                      );
                                    } else {
                                      cubit.update(
                                        tanksEntity: inherited.tanksEntity,
                                        idCentroVenta: inherited.saleCenter.id,
                                        idArticulo: inherited.article.id,
                                        capacidad:
                                            inherited.capacidadField.getValue(),
                                        alturaTanque: inherited
                                            .alturaTanqueField
                                            .getValue(),
                                        descripcion: inherited.descripcionField
                                            .getValue(),
                                        porcentajeMinimoCombustible: inherited
                                            .porcentajeMinimoCombustibleField
                                            .getValue(),
                                        alturaOffset: inherited
                                            .alturaOffsetField
                                            .getValue(),
                                        factorInicioDescargue: '0',
                                        codigo: '0',
                                        alturaAguaOffset: '0',
                                        offsetInclinacion: '0',
                                        estado: true,
                                        modificable: false,
                                        manejaMm: false,
                                        idConsolaTanque: inherited.console.id,
                                      );
                                    }
                                  }
                                },
                                text: inherited.typeOperation ==
                                        TypeOperation.create
                                    ? 'Crear Consola'
                                    : 'Actualizar Consola',
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
