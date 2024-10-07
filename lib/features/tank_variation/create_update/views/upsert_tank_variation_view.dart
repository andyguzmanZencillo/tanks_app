import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/tank_variation/create_update/helper/upsert_tank_variation_listener.dart';
import 'package:tanks_app/features/tank_variation/create_update/views/upsert_tank_variation_body.dart';

class UpsertTankVariationView extends StatelessWidget {
  const UpsertTankVariationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        UpsertTanksVariationListener.upsertTankVariation(),
      ],
      child: FullWidgetGeneric(
        onInit: () {},
        onDispose: () {},
        child: const UpsertTankVariationBody(),
      ),
    );
  }
}
