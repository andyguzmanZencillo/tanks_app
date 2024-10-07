import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/dialog_handler/bloc/dialog_handler_bloc.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/validator_field/valid.dart';
import 'package:tanks_app/core/util/validator_field/validator_field.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/field_custom.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/console/create_update/cubit/upsert_console_cubit.dart';
import 'package:tanks_app/features/console/create_update/views/upsert_console_inherited.dart';
import 'package:tanks_app/features/sign_in/widgets/field_auth.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertConsolePage extends StatelessWidget {
  const UpsertConsolePage({
    required this.typeOperation,
    this.consoleEntity = const ConsoleEntity.empty(),
    super.key,
  });
  final TypeOperation typeOperation;
  final ConsoleEntity consoleEntity;

  static Route<bool?> route({
    required TypeOperation typeOperation,
    ConsoleEntity consoleEntity = const ConsoleEntity.empty(),
  }) {
    return MaterialPageRoute<bool?>(
      builder: (context) => UpsertConsolePage(
        typeOperation: typeOperation,
        consoleEntity: consoleEntity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UpsertConsoleInherited(
      typeOperation: typeOperation,
      consoleEntity: consoleEntity,
      child: BlocProvider(
        create: (context) => sl<UpsertConsoleCubit>(),
        child: const UpsertConsoleView(),
      ),
    );
  }
}

class UpsertConsoleView extends StatelessWidget {
  const UpsertConsoleView({super.key});

  @override
  Widget build(BuildContext context) {
    final dialog = context.read<DialogHandlerBloc>();
    final inherited = UpsertConsoleInherited.of(context);
    return BlocListener<UpsertConsoleCubit, UpsertConsoleState>(
      listener: (context, state) {
        final s = state.upsertStatus;
        if (s == UpsertStatus.loading) {
          /*if (inherited.typeOperation == TypeOperation.create) {
            dialog.onOpenNotification(
              message: 'Creando centro de venta...',
              dialogType: DialogType.loading,
            );
          } else {
            dialog.onOpenNotification(
              message: 'Actualizando Centro de venta...',
              dialogType: DialogType.loading,
            );
          }
        } else if (s == UpsertStatus.error) {
          dialog.onOpenNotification(
            dialogData: DialogData(
              barrierDismissible: false,
              message: inherited.typeOperation == TypeOperation.create
                  ? 'Error al crear centro de venta'
                  : 'Error al actualizar centro de venta',
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
                  ? 'Centro de venta creado exitosamente'
                  : 'Centro de venta actualizado exitosamente',
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
          );*/
        }
      },
      child: const UpsertConsoleBody(),
    );
  }
}

class UpsertConsoleBody extends StatelessWidget {
  const UpsertConsoleBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertConsoleInherited.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: BlocContext<UpsertConsoleCubit, UpsertConsoleState>(
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
                                ? 'Creación de una consola de tanque'
                                : 'Actualización de una consola de tanque',
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
                                icon: const Icon(Icons.computer),
                                labelSingle: false,
                                controller: inherited.consolaField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Consola requerido',
                                    ),
                                  ],
                                ),
                                label: 'Consola',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.description),
                                labelSingle: false,
                                controller: inherited.descripcionField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Descripción requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Descripción',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.input),
                                labelSingle: false,
                                controller:
                                    inherited.idConsolaTanqueProtocoloField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error:
                                          'Campo ID Consola Tanque Protocolo requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'ID Consola Tanque Protocolo',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.type_specimen),
                                labelSingle: false,
                                controller: inherited.tipoField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Tipo requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Tipo',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.network_wifi),
                                labelSingle: false,
                                controller: inherited.ipField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo IP requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'IP',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.link),
                                labelSingle: false,
                                controller: inherited.socketField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Socket requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Socket',
                              ),
                              FieldTextCustom(
                                icon: const Icon(Icons.link),
                                isPassword: true,
                                labelSingle: false,
                                controller: ControllerField(),
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Socket requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Socket',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.portable_wifi_off),
                                labelSingle: false,
                                controller: inherited.puertoSerialField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Puerto Serial requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Puerto Serial',
                              ),
                              FieldAuth2(
                                icon: const Icon(Icons.vpn_key),
                                labelSingle: false,
                                controller: inherited.contrasenaIpField,
                                validator: (value) => Validator.validation(
                                  value,
                                  [
                                    RequiredValid(
                                      error: 'Campo Contraseña IP requerido',
                                    ),
                                  ],
                                ),
                                onChanged: (p0) {},
                                label: 'Contraseña IP',
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
                                      /*cubit.create(
                                        centroVenta:
                                            inherited.saleCenter.getValue(),
                                        descripcion:
                                            inherited.description.getValue(),
                                        correo: inherited.email.getValue(),
                                      );*/
                                    } else {
                                      /*cubit.updateArticle(
                                        salesCenterEntity:
                                            inherited.salesCenterEntity,
                                        centroVenta:
                                            inherited.saleCenter.getValue(),
                                        descripcion:
                                            inherited.description.getValue(),
                                        correo: inherited.email.getValue(),
                                      );*/
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
