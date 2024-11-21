import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/tanks/cubit/tanks_cubit.dart';
import 'package:tanks_app/features/tanks/cubit/upsert_tanks_cubit.dart';
import 'package:tanks_app/features/tanks/helpers/extend_fields_tanks.dart';
import 'package:tanks_app/features/tanks/helpers/map_inherited_to_entity.dart';
import 'package:tanks_app/features/tanks/helpers/upsert_tanks_inherited.dart';
import 'package:tanks_app/features/tanks/widgets/dropdown_pro.dart';
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
          BlocProvider(create: (_) => sl<UpsertTanksCubit>()),
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
        ListenerPro<UpsertTanksCubit, UpsertTanksState>().listen(
          onPressedSuccess: () {
            context.pop();
            context.read<TanksCubit>().getAll();
          },
        ),
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
              ? 'Nuevo tanque'
              : 'Actualizar tanque',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
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

                                return DropdownCustomPro(
                                  controller: inherited.saleCenter,
                                  validator: (p0) {
                                    if (p0 == null) {
                                      return 'Valor requerido';
                                    }
                                    return null;
                                  },
                                  label: 'Centro de venta',
                                  title: 'Centro de venta *',
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
                                return DropdownCustomPro(
                                  controller: inherited.article,
                                  validator: (p0) {
                                    if (p0 == null) {
                                      return 'Valor requerido';
                                    }
                                    return null;
                                  },
                                  label: 'Articulos',
                                  title: 'Articulos',
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

                                return DropdownCustomPro(
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
                                  child: TextFieldPro(
                                    controller: inherited.capacidadField,
                                    extendTextField: ExtendFieldsTanks.capacity,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFieldPro(
                                    controller: inherited.alturaTanqueField,
                                    extendTextField:
                                        ExtendFieldsTanks.alturaTanque,
                                  ),
                                ),
                              ],
                            ),
                            TextFieldPro(
                              controller: inherited.descripcionField,
                              extendTextField: ExtendFieldsTanks.descripcion,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFieldPro(
                                    controller: inherited.alturaOffsetField,
                                    extendTextField:
                                        ExtendFieldsTanks.alturaOffset,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFieldPro(
                                    controller:
                                        inherited.factorInicioDescargueField,
                                    extendTextField:
                                        ExtendFieldsTanks.factorInicioDescargue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFieldPro(
                                    controller: inherited.codigoField,
                                    extendTextField: ExtendFieldsTanks.codigo,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFieldPro(
                                    controller: inherited.alturaAguaOffsetField,
                                    extendTextField:
                                        ExtendFieldsTanks.alturaAguaOffset,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFieldPro(
                                    controller:
                                        inherited.offsetInclinacionField,
                                    extendTextField:
                                        ExtendFieldsTanks.offsetInclinacion,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFieldPro(
                                    controller: inherited
                                        .porcentajeMinimoCombustibleField,
                                    extendTextField: ExtendFieldsTanks
                                        .porcentajeMinimoCombustible,
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
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();

                                        if (isCreate) {
                                          cubit.create(
                                            tanksEntity:
                                                inherited.toTankEntity(),
                                          );
                                        } else if (isUpdate) {
                                          cubit.update(
                                            tanksEntity:
                                                inherited.toTankEntityUpdate(
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
            ],
          );
        },
      ),
    );
  }
}
