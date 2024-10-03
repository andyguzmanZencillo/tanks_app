import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/features.dart';
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
import 'package:tanks_app/features/capacity_table/create_update/cubit/upsert_capacity_table_cubit.dart';
import 'package:tanks_app/features/capacity_table/create_update/views/upsert_capacity_table_inherited.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';
import 'package:tanks_app/features/tanks/create_update/widgets/dropdown.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertCapacityTablePage extends StatelessWidget {
  const UpsertCapacityTablePage({
    required this.typeOperation,
    this.consoleEntity = const CapacityTableEntity.empty(),
    super.key,
  });
  final TypeOperation typeOperation;
  final CapacityTableEntity consoleEntity;

  static Route<bool?> route({
    required TypeOperation typeOperation,
    CapacityTableEntity consoleEntity = const CapacityTableEntity.empty(),
  }) {
    return MaterialPageRoute<bool?>(
      builder: (context) => UpsertCapacityTablePage(
        typeOperation: typeOperation,
        consoleEntity: consoleEntity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UpsertCapacityTableInherited(
      typeOperation: typeOperation,
      tanksEntity: consoleEntity,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<UpsertCapacityTableCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<TanksCubit>()..getAll(),
          ),
        ],
        child: const UpsertCapacityTableView(),
      ),
    );
  }
}

class UpsertCapacityTableView extends StatelessWidget {
  const UpsertCapacityTableView({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = context.read<DialogHandlerCubit>();
    final inherited = UpsertCapacityTableInherited.of(context);
    return BlocListener<UpsertCapacityTableCubit, UpsertCapacityTableState>(
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
      child: const UpsertCapacityTableBody(),
    );
  }
}

class UpsertCapacityTableBody extends StatelessWidget {
  const UpsertCapacityTableBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertCapacityTableInherited.of(context);

    final isCreate = inherited.typeOperation == TypeOperation.create;
    final isUpdate = inherited.typeOperation == TypeOperation.update;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: BlocContext<UpsertCapacityTableCubit, UpsertCapacityTableState>(
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
                              BlocSelector<TanksCubit, TanksState,
                                  List<TanksEntity>>(
                                selector: (state) {
                                  return state.tanks;
                                },
                                builder: (context, state) {
                                  if (state.isEmpty) {
                                    return const SizedBox.shrink();
                                  }

                                  TanksEntity? articleEntity;

                                  if (isUpdate) {
                                    articleEntity = state.firstWhereOrNull(
                                      (element) =>
                                          element.idTanque ==
                                          inherited.tanksEntity.idTanque,
                                    );
                                  }
                                  return DropdownCustom(
                                    controller: inherited.tanque,
                                    validator: (p0) {
                                      if (p0 == null) {
                                        return 'Valor requerido';
                                      }
                                      return null;
                                    },
                                    label: 'Tanques',
                                    value: articleEntity,
                                    showDecoration: false,
                                    isLabelTitle: true,
                                    items: state,
                                  );
                                },
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.scale),
                                labelSingle: false,
                                controller: inherited.alturaTanqueField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Altura tanque requerido',
                                    ),
                                  ],
                                ),
                                label: 'Altura tanque',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.height),
                                labelSingle: false,
                                controller: inherited.volumen,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Volumenrequerido',
                                    ),
                                  ],
                                ),
                                label: 'Volumen',
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
                                        alturaTanque: inherited
                                            .alturaTanqueField
                                            .getValue(),
                                        volumen: inherited.volumen.getValue(),
                                        idTanque: inherited.tanque.id,
                                      );
                                    } else {
                                      cubit.update(
                                        tanksEntity: inherited.tanksEntity,
                                        alturaTanque: inherited
                                            .alturaTanqueField
                                            .getValue(),
                                        volumen: inherited.volumen.getValue(),
                                        idTanque: inherited.tanque.id,
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
