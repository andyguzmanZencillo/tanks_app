import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/features.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/helpers/listener/listener_generic.dart';
import 'package:tanks_app/core/util/extensions/extension_string.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/helpers/create_update_inherited.dart';
import 'package:tanks_app/features/console/cubit/console_cubit.dart';
import 'package:tanks_app/features/console/helpers/upsert_console_inherited.dart';
import 'package:tanks_app/features/console_protocol/cubit/console_cubit.dart';
import 'package:tanks_app/features/tanks/widgets/dropdown.dart';
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
    final consoleProtocolCubit = context.read<ConsoleProtocolCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            title: 'Consola *',
                            maxLength: 35,
                          ),
                          TextFieldCustomPro(
                            controller: inherited.descripcionField,
                            label: 'Descripción',
                            title: 'Descripción *',
                            maxLength: 35,
                          ),
                          BlocSelector<
                              ConsoleProtocolCubit,
                              ConsoleProtocolState,
                              List<ConsoleProtocolEntity>>(
                            selector: (state) {
                              return state.list;
                            },
                            builder: (context, state) {
                              if (state.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              ConsoleProtocolEntity? articleEntity;

                              if (inherited.typeOperation ==
                                  TypeOperation.update) {
                                articleEntity = state.firstWhereOrNull(
                                  (element) =>
                                      element.idConsolaProtocol ==
                                      consoleCubit.state.selected
                                          .idConsolaTanqueProtocolo,
                                );
                              }
                              return DropdownCustom(
                                controller: inherited.consoleProtocol,
                                validator: (p0) {
                                  if (p0 == null) {
                                    return 'Valor requerido';
                                  }
                                  return null;
                                },
                                label: 'Consola Tanque Protocolo',
                                title: 'Consola Tanque Protocolo *',
                                value: articleEntity,
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
                                child: Builder(
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
                                    if (inherited.typeOperation ==
                                        TypeOperation.update) {
                                      value = items.firstWhereOrNull(
                                        (element) =>
                                            element.text ==
                                            consoleCubit.state.selected.tipo,
                                      );
                                    }

                                    return DropdownCustom(
                                      controller: inherited.tipoField,
                                      validator: (p0) {
                                        if (p0 == null) {
                                          return 'Valor requerido';
                                        }
                                        return null;
                                      },
                                      label: 'Tipo',
                                      title: 'Tipo *',
                                      value: value,
                                      showDecoration: false,
                                      isLabelTitle: true,
                                      items: items,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFieldCustomPro(
                                  controller: inherited.ipField,
                                  label: 'IP',
                                  maxLength: 15,
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
                                  inputType: TextInputType.number,
                                  label: 'Socket',
                                  title: 'Socket *',
                                  maxLength: 6,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFieldCustomPro(
                                  controller: inherited.puertoSerialField,
                                  label: 'Puerto Serial',
                                  maxLength: 5,
                                ),
                              ),
                            ],
                          ),
                          TextFieldCustomPro(
                            controller: inherited.contrasenaIpField,
                            title: 'Contraseña IP *',
                            label: 'Contraseña IP',
                            maxLength: 15,
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
      ),
    );
  }
}
