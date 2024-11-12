import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';

class TankVariationListener {
  static BlocListener<TankVariationCubit, TankVariationState> tankVariation() {
    return BlocListener<TankVariationCubit, TankVariationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final s = state.status;
        if (s == GeneralStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Buscando variación de tanques...',
              );
            },
          );
        } else if (s == GeneralStatus.error) {
          context.pop();
        } else if (s == GeneralStatus.success) {
          context.pop();
        }
      },
    );
  }
}
