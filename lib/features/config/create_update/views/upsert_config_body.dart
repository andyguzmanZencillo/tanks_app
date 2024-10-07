import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/bloc_generics.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';
import 'package:tanks_app/core/widgets/custom_form_hour_field.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/config/create_update/cubit/upsert_config_cubit.dart';
import 'package:tanks_app/features/config/create_update/helper/upsert_config_inherited.dart';
import 'package:tanks_app/features/config/list/cubit/config_cubit.dart';

class UpsertConfigBody extends StatelessWidget {
  const UpsertConfigBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = UpsertConfigInherited.of(context);
    final configCubit = context.read<ConfigCubit>();

    final controllerHoraInicial = TextEditingController();
    final controllerHoraFinal = TextEditingController();

    if (inherited.typeOperation == TypeOperation.update) {
      controllerHoraInicial.text =
          configCubit.state.configSelected.horaInicioZeta;
      controllerHoraFinal.text = configCubit.state.configSelected.horaFinZeta;
    }

    return BlocContext<UpsertConfigCubit, UpsertConfigState>(
      builder: (context, cubit) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 238, 238, 238),
          appBar: AppBar(
            title: const Text('Configuración'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 238, 238, 238),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomFormHourField(
                        label: 'Hora inicial',
                        controller: controllerHoraInicial,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomFormHourField(
                        label: 'Hora final',
                        controller: controllerHoraFinal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ButtonCustom(
                  onPressed: () {
                    if (controllerHoraInicial.text.isNotEmpty &&
                        controllerHoraFinal.text.isNotEmpty) {
                      if (inherited.typeOperation == TypeOperation.create) {
                        cubit.create(
                          horaInicial: controllerHoraInicial.text,
                          horaFinal: controllerHoraFinal.text,
                        );
                      } else {
                        cubit.update(
                          configEntity: configCubit.state.configSelected,
                          horaInicial: controllerHoraInicial.text,
                          horaFinal: controllerHoraFinal.text,
                        );
                      }
                    }
                  },
                  text: inherited.typeOperation == TypeOperation.update
                      ? 'Actualizar configuración'
                      : 'Registrar Configuración',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
