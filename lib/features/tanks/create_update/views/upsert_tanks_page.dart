import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/list/cubit/article_list_cubit.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/tanks/create_update/cubit/upsert_tanks_cubit.dart';
import 'package:tanks_app/features/tanks/create_update/helpers/upsert_tanks_listener.dart';
import 'package:tanks_app/features/tanks/create_update/views/upsert_tanks_inherited.dart';
import 'package:tanks_app/features/tanks/create_update/widgets/dropdown.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertTanksPage extends StatelessWidget {
  const UpsertTanksPage({
    required this.typeOperation,
    super.key,
  });
  final TypeOperation typeOperation;

  @override
  Widget build(BuildContext context) {
    return UpsertTanksInherited(
      typeOperation: typeOperation,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<UpsertTanksCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<SalesCenterCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<ConsoleCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<ArticleListCubit>(),
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
    return MultiBlocListener(
      listeners: [
        DialogListener.upsertTank(),
        DialogListener.upsertTankPrepare(),
      ],
      child: FullWidgetGeneric(
        onInit: () async {
          await _initializeCubits(context);
        },
        onDispose: () {},
        child: const UpsertTanksBody(),
      ),
    );
  }

  Future<void> _initializeCubits(BuildContext context) async {
    final upsert = context.read<UpsertTanksCubit>();
    final consoleCubit = context.read<ConsoleCubit>();
    final salesCenterCubit = context.read<SalesCenterCubit>();
    final articleCubit = context.read<ArticleListCubit>();
    await upsert.functionState(() async {
      if (!await consoleCubit.getAll()) {
        return (false, 'Error al obtener la lista de consolas');
      }
      if (!await salesCenterCubit.getAll()) {
        return (false, 'Error al obtener la lista de centros de venta');
      }
      if (!await articleCubit.getArticles()) {
        return (false, 'Error al obtener la lista de articulos');
      }

      return (true, null);
    });
  }
}

class UpsertTanksBody extends StatelessWidget {
  const UpsertTanksBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertTanksInherited.of(context);
    final tanksCubit = context.read<TanksCubit>();

    final isCreate = inherited.typeOperation == TypeOperation.create;
    final isUpdate = inherited.typeOperation == TypeOperation.update;
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
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
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                              BlocSelector<SalesCenterCubit, SalesCenterState,
                                  List<SalesCenterEntity>>(
                                selector: (state) {
                                  return state.list;
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
                                          tanksCubit
                                              .state.selected.idCentroVenta,
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
                              BlocSelector<ArticleListCubit, ArticleListState,
                                  List<ArticleEntity>>(
                                selector: (state) {
                                  return state.list;
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
                                          tanksCubit.state.selected.idArticulo,
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
                                  return state.list;
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
                                          tanksCubit
                                              .state.selected.idConsolaTanque,
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
                              TextFieldCustomPro(
                                controller: inherited.capacidadField,
                                label: 'Capacidad',
                              ),
                              TextFieldCustomPro(
                                controller: inherited.alturaTanqueField,
                                label: 'Altura Tanque',
                              ),
                              TextFieldCustomPro(
                                controller: inherited.descripcionField,
                                label: 'Descripción',
                              ),
                              TextFieldCustomPro(
                                controller:
                                    inherited.porcentajeMinimoCombustibleField,
                                label: 'Porcentaje Mínimo Combustible',
                              ),
                              TextFieldCustomPro(
                                controller: inherited.alturaOffsetField,
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
                                        tanksEntity: tanksCubit.state.selected,
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
                                    ? 'Crear Tanque'
                                    : 'Actualizar Tanque',
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
