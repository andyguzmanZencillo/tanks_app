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
import 'package:tanks_app/features/tanks/create_update/cubit/upsert_tanks_cubit.dart';
import 'package:tanks_app/features/tanks/create_update/helpers/map_inherited_to_entity.dart';
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
    final inheited = UpsertTanksInherited.of(context);
    final upsertCubit = context.read<UpsertTanksCubit>();
    final tanksCubit = context.read<TanksCubit>();
    return MultiBlocListener(
      listeners: [
        UpsertTanksListener.upsertTank(
          onTap: tanksCubit.getAll,
        ),
        UpsertTanksListener.upsertTankPrepare(),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<UpsertTanksCubit>().prepareData();
          if (inheited.typeOperation == TypeOperation.update) {
            inheited.setData(
              tanksCubit.state.selected,
            );
            upsertCubit.changeChecks(
              statusCheck: tanksCubit.state.selected.estado,
              modificable: tanksCubit.state.selected.modificable,
              manejaMm: tanksCubit.state.selected.manejaMm,
            );
          }
        },
        child: const UpsertTanksBody(),
      ),
    );
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
      appBar: AppBar(
        title: Text(
          inherited.typeOperation == TypeOperation.create
              ? 'Creación de un tanque'
              : 'Actualización de un tanque',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
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
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 20,
                      ),
                      child: Form(
                        key: inherited.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocSelector<UpsertTanksCubit, UpsertTanksState,
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
                                        tanksCubit.state.selected.idCentroVenta,
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
                            BlocSelector<UpsertTanksCubit, UpsertTanksState,
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
                            BlocSelector<UpsertTanksCubit, UpsertTanksState,
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
                                        tanksCubit
                                            .state.selected.idConsolaTanque,
                                  );
                                }

                                return DropdownCustom(
                                  controller: inherited.console,
                                  validator: (p0) {
                                    /*if (p0 == null) {
                                      return 'Valor requerido';
                                    }*/
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFieldCustomPro(
                                    controller: inherited.capacidadField,
                                    label: 'Capacidad',
                                    title: 'Capacidad *',
                                    maxLength: 10,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFieldCustomPro(
                                    controller: inherited.alturaTanqueField,
                                    label: 'Altura Tanque',
                                    title: 'Altura Tanque *',
                                    maxLength: 6,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFieldCustomPro(
                              controller: inherited.descripcionField,
                              title: 'Descripción *',
                              label: 'Descripción',
                              maxLength: 40,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFieldCustomPro(
                                    controller: inherited.alturaOffsetField,
                                    label: 'Altura Offset',
                                    title: 'Altura Offset *',
                                    maxLength: 6,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFieldCustomPro(
                                    controller:
                                        inherited.factorInicioDescargueField,
                                    label: 'Fact. inicio descargue',
                                    title: 'Fact. inicio descargue *',
                                    maxLength: 6,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFieldCustomPro(
                                    controller: inherited.codigoField,
                                    label: 'Codigo',
                                    title: 'Codigo *',
                                    maxLength: 7,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFieldCustomPro(
                                    controller: inherited.alturaAguaOffsetField,
                                    label: 'Altura agua offset',
                                    title: 'Altura agua offset *',
                                    maxLength: 6,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFieldCustomPro(
                                    controller:
                                        inherited.offsetInclinacionField,
                                    label: 'Offset inclinación',
                                    title: 'Offset inclinación *',
                                    maxLength: 6,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFieldCustomPro(
                                    controller: inherited
                                        .porcentajeMinimoCombustibleField,
                                    label: '% Mín. Combustible',
                                    title: '% Mín. Combustible *',
                                    maxLength: 6,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            BlocSelector<UpsertTanksCubit, UpsertTanksState,
                                bool>(
                              selector: (state) => state.statusCheck,
                              builder: (context, check) {
                                return CheckboxListTile(
                                  title: const Text(
                                    'Estado',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: check,
                                  onChanged: (newValue) {
                                    context
                                        .read<UpsertTanksCubit>()
                                        .changeStatusCheck(
                                          check: newValue ?? false,
                                        );
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                );
                              },
                            ),
                            BlocSelector<UpsertTanksCubit, UpsertTanksState,
                                bool>(
                              selector: (state) => state.modificable,
                              builder: (context, check) {
                                return CheckboxListTile(
                                  title: const Text(
                                    'Modificable',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: check,
                                  onChanged: (newValue) {
                                    context
                                        .read<UpsertTanksCubit>()
                                        .changeModificableCheck(
                                          check: newValue ?? false,
                                        );
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                );
                              },
                            ),
                            BlocSelector<UpsertTanksCubit, UpsertTanksState,
                                bool>(
                              selector: (state) => state.manejaMm,
                              builder: (context, check) {
                                return CheckboxListTile(
                                  title: const Text(
                                    'Maneja MM',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: check,
                                  onChanged: (newValue) {
                                    context
                                        .read<UpsertTanksCubit>()
                                        .changeManejaMmCheck(
                                          check: newValue ?? false,
                                        );
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonCustom(
                              onPressed: () {
                                final validResult = inherited.valid();
                                if (validResult.isPassed) {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  if (isCreate) {
                                    cubit.create(
                                      tanksEntity: inherited.toTankEntity(),
                                    );
                                  } else if (isUpdate) {
                                    cubit.update(
                                      tanksEntity: inherited.toTankEntityUpdate(
                                        tanksCubit.state.selected,
                                      ),
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
