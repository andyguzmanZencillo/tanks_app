import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/widgets/dialogs/dialogs.dart';
import 'package:tanks_app/features/sales_center/list/cubit/sales_center_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';

class TankVariationListener {
  static BlocListener<TankVariationCubit, TankVariationState> tankVariation() {
    return BlocListener<TankVariationCubit, TankVariationState>(
      listenWhen: (previous, current) =>
          previous.consoleStatus != current.consoleStatus,
      listener: (context, state) {
        final s = state.consoleStatus;
        if (s == TankVariationStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Buscando variación de tanques...',
              );
            },
          );
        } else if (s == TankVariationStatus.error) {
          context.pop();
          /*showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: 'Error al buscar variación de tanques',
                  title: 'Error',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );*/
        } else if (s == TankVariationStatus.success) {
          context.pop();
        }
      },
    );
  }

  static BlocListener<SalesCenterCubit, SalesCenterState> event({
    void Function()? loading,
    void Function()? success,
    void Function()? error,
  }) {
    return BlocListener<SalesCenterCubit, SalesCenterState>(
      listenWhen: (previous, current) =>
          previous.salesCenterStatus != current.salesCenterStatus,
      listener: (context, state) {
        if (state.salesCenterStatus == SalesCenterStatus.loading) {
          loading?.call();
        } else if (state.salesCenterStatus == SalesCenterStatus.error) {
          error?.call();
        } else if (state.salesCenterStatus == SalesCenterStatus.success) {
          success?.call();
        }
      },
    );
  }

  static BlocListener<SalesCenterCubit, SalesCenterState> salesCenter() {
    return BlocListener<SalesCenterCubit, SalesCenterState>(
      listenWhen: (previous, current) =>
          previous.salesCenterStatus != current.salesCenterStatus,
      listener: (context, state) {
        final status = state.salesCenterStatus;
        final message = state.errorMessage;
        if (status == SalesCenterStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Buscando centros de ventas',
              );
            },
          );
        } else if (status == SalesCenterStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message ?? 'Error al buscar centros de ventas',
                  title: 'Error',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (status == SalesCenterStatus.success) {
          context.pop();
        }
      },
    );
  }

  static BlocListener<TanksCubit, TanksState> tanks() {
    return BlocListener<TanksCubit, TanksState>(
      listenWhen: (previous, current) =>
          previous.tanksStatus != current.tanksStatus,
      listener: (context, state) {
        final status = state.tanksStatus;
        final message = state.messageError;

        if (status == TanksStatus.loading) {
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const DialogText(
                text: 'Buscando tanques...',
              );
            },
          );
        } else if (status == TanksStatus.error) {
          context.pop();
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return DialogManagment.error(
                dialogData: DialogData(
                  barrierDismissible: false,
                  message: message ?? 'Error al buscar tanques',
                  title: 'Error',
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Cerrar',
                ),
              );
            },
          );
        } else if (status == TanksStatus.success) {
          context.pop();
        }
      },
    );
  }
}
