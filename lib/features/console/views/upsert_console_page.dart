import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_new.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/console/cubit/console_cubit.dart';
import 'package:tanks_app/features/console/helpers/extend_fields_console.dart';
import 'package:tanks_app/features/console/helpers/upsert_console_inherited.dart';
import 'package:tanks_app/features/console_protocol/cubit/console_cubit.dart';
import 'package:tanks_app/features/tanks/widgets/dropdown_pro.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<ConsoleProtocolCubit>(),
          ),
        ],
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
        ListenerPro<ConsoleProtocolCubit, ConsoleProtocolState>().listen(),
      ],
      child: FullWidgetGeneric(
        onInit: () async {
          await context.read<ConsoleProtocolCubit>().getAll();
          if (inherited.typeOperation == TypeOperation.update) {
            inherited.setDate(consoleCubit.state.selected);
          }
        },
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
        title: Text(
          inherited.typeOperation == TypeOperation.create
              ? 'Nueva consola'
              : 'Modificar consola',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 16, 16, 34),
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                    TextFieldPro(
                      controller: inherited.consolaField,
                      extendTextField: ExtendFieldsConsole.console,
                    ),
                    TextFieldPro(
                      controller: inherited.descripcionField,
                      extendTextField: ExtendFieldsConsole.description,
                    ),
                    BlocSelector<ConsoleProtocolCubit, ConsoleProtocolState,
                        List<ConsoleProtocolEntity>>(
                      selector: (state) {
                        return state.list;
                      },
                      builder: (context, state) {
                        if (state.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        ConsoleProtocolEntity? articleEntity;

                        if (inherited.typeOperation == TypeOperation.update) {
                          articleEntity = state.firstWhereOrNull(
                            (element) =>
                                element.idConsolaProtocol ==
                                consoleCubit
                                    .state.selected.idConsolaTanqueProtocolo,
                          );
                        }
                        return DropdownCustomPro(
                          controller: inherited.consoleProtocol,
                          validator: (p0) {
                            if (p0 == null) {
                              return 'Valor requerido';
                            }
                            return null;
                          },
                          label: 'Consola Tanque Protocolo',
                          title: 'Consola Tanque Protocolo',
                          value: articleEntity,
                          showDecoration: false,
                          isLabelTitle: true,
                          items: state,
                        );
                      },
                    ),
                    Builder(
                      builder: (context) {
                        final items = [
                          const ValueExtend<String>(
                            id: 1,
                            text: 'Serial',
                          ),
                          const ValueExtend<String>(
                            id: 2,
                            text: 'IP',
                          ),
                          const ValueExtend<String>(
                            id: 3,
                            text: 'Test',
                          ),
                        ];
                        ValueExtend<String>? value;
                        if (inherited.typeOperation == TypeOperation.update) {
                          value = items.firstWhereOrNull(
                            (element) =>
                                element.text ==
                                consoleCubit.state.selected.tipo,
                          );
                        }

                        return DropdownCustomPro(
                          controller: inherited.tipoField,
                          validator: (p0) {
                            if (p0 == null) {
                              return 'Valor requerido';
                            }
                            return null;
                          },
                          label: 'Tipo',
                          title: 'Tipo',
                          value: value,
                          showDecoration: false,
                          isLabelTitle: true,
                          items: items,
                        );
                      },
                    ),
                    TextFieldPro(
                      controller: inherited.ipField,
                      extendTextField: ExtendFieldsConsole.ip,
                    ),
                    TextFieldPro(
                      controller: inherited.socketField,
                      extendTextField: ExtendFieldsConsole.socket,
                    ),
                    TextFieldPro(
                      controller: inherited.puertoSerialField,
                      extendTextField: ExtendFieldsConsole.portSerial,
                    ),
                    TextFieldPro(
                      controller: inherited.contrasenaIpField,
                      extendTextField: ExtendFieldsConsole.passwordIp,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonCustom(
                            text: 'Cancelar',
                            backgroundColor: Colors.red,
                            onPressed: () {},
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
                                if (inherited.typeOperation ==
                                    TypeOperation.create) {
                                  consoleCubit.create(
                                    consola: inherited.consolaField.getValue(),
                                    descripcion:
                                        inherited.descripcionField.getValue(),
                                    idConsolaTanqueProtocolo:
                                        inherited.consoleProtocol.getValue().id,
                                    tipo: inherited.tipoField.getValue().text,
                                    ip: inherited.ipField.getValue(),
                                    socket: inherited.socketField.getValue(),
                                    puertoSerial:
                                        inherited.puertoSerialField.getValue(),
                                    contrasenaIp:
                                        inherited.contrasenaIpField.getValue(),
                                  );
                                } else {
                                  consoleCubit.updateArticle(
                                    consoleEntity: consoleCubit.state.selected,
                                    consola: inherited.consolaField.getValue(),
                                    descripcion:
                                        inherited.descripcionField.getValue(),
                                    idConsolaTanqueProtocolo: inherited
                                        .idConsolaTanqueProtocoloField
                                        .getValue()
                                        .toIntSafe(),
                                    tipo: inherited.tipoField.getValue().text,
                                    ip: inherited.ipField.getValue(),
                                    socket: inherited.socketField.getValue(),
                                    puertoSerial:
                                        inherited.puertoSerialField.getValue(),
                                    contrasenaIp:
                                        inherited.contrasenaIpField.getValue(),
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
