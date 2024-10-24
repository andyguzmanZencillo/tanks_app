import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/console/create_update/cubit/upsert_console_cubit.dart';
import 'package:tanks_app/features/console/create_update/helpers/upsert_console_listener.dart';
import 'package:tanks_app/features/console/create_update/views/upsert_console_inherited.dart';
import 'package:tanks_app/features/console/list/cubit/console_cubit.dart';
import 'package:tanks_app/injection/injection.dart';

class UpsertConsolePage extends StatelessWidget {
  const UpsertConsolePage({
    required this.typeOperation,
    super.key,
  });
  final TypeOperation typeOperation;

  @override
  Widget build(BuildContext context) {
    return UpsertConsoleInherited(
      typeOperation: typeOperation,
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
    final consoleCubit = context.read<ConsoleCubit>();
    final inherited = UpsertConsoleInherited.of(context);
    return MultiBlocListener(
      listeners: [
        UpsertConsoleListener.upsertConsole(
          onTap: (p0) {
            consoleCubit.getAll();
          },
        ),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          if (inherited.typeOperation == TypeOperation.update) {
            inherited.setDate(consoleCubit.state.selected);
          }
        },
        onDispose: () {},
        child: const UpsertConsoleBody(),
      ),
    );
  }
}

class UpsertConsoleBody extends StatelessWidget {
  const UpsertConsoleBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertConsoleInherited.of(context);
    final consoleCubit = context.read<ConsoleCubit>();
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
                              TextFieldCustomPro(
                                controller: inherited.consolaField,
                                label: 'Consola',
                              ),
                              TextFieldCustomPro(
                                controller: inherited.descripcionField,
                                label: 'Descripción',
                              ),
                              TextFieldCustomPro(
                                controller:
                                    inherited.idConsolaTanqueProtocoloField,
                                label: 'ID Consola Tanque Protocolo',
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextFieldCustomPro(
                                      controller: inherited.tipoField,
                                      label: 'Tipo',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFieldCustomPro(
                                      controller: inherited.ipField,
                                      label: 'IP',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextFieldCustomPro(
                                      controller: inherited.socketField,
                                      label: 'Socket',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFieldCustomPro(
                                      controller: inherited.puertoSerialField,
                                      label: 'Puerto Serial',
                                    ),
                                  ),
                                ],
                              ),
                              TextFieldCustomPro(
                                controller: inherited.contrasenaIpField,
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
                                      cubit.create(
                                        consola:
                                            inherited.consolaField.getValue(),
                                        descripcion: inherited.descripcionField
                                            .getValue(),
                                        idConsolaTanqueProtocolo: inherited
                                            .idConsolaTanqueProtocoloField
                                            .getValue()
                                            .toIntSafe(),
                                        tipo: inherited.tipoField.getValue(),
                                        ip: inherited.ipField.getValue(),
                                        socket:
                                            inherited.socketField.getValue(),
                                        puertoSerial: inherited
                                            .puertoSerialField
                                            .getValue(),
                                        contrasenaIp: inherited
                                            .contrasenaIpField
                                            .getValue(),
                                      );
                                    } else {
                                      cubit.updateArticle(
                                        consoleEntity:
                                            consoleCubit.state.selected,
                                        consola:
                                            inherited.consolaField.getValue(),
                                        descripcion: inherited.descripcionField
                                            .getValue(),
                                        idConsolaTanqueProtocolo: inherited
                                            .idConsolaTanqueProtocoloField
                                            .getValue()
                                            .toIntSafe(),
                                        tipo: inherited.tipoField.getValue(),
                                        ip: inherited.ipField.getValue(),
                                        socket:
                                            inherited.socketField.getValue(),
                                        puertoSerial: inherited
                                            .puertoSerialField
                                            .getValue(),
                                        contrasenaIp: inherited
                                            .contrasenaIpField
                                            .getValue(),
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
