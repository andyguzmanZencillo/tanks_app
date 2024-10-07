import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/config/create_update/helper/upsert_config_listener.dart';
import 'package:tanks_app/features/config/create_update/views/upsert_config_body.dart';

class UpsertConfigView extends StatelessWidget {
  const UpsertConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        UpsertConfigistener.upsertTankVariation(),
      ],
      child: FullWidgetGeneric(
        onInit: () {},
        onDispose: () {},
        child: const UpsertConfigBody(),
      ),
    );
  }
}
