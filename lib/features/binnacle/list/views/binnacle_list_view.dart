import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/binnacle/list/cubit/binnacle_cubit.dart';
import 'package:tanks_app/features/binnacle/list/helpers/binnacle_listener.dart';
import 'package:tanks_app/features/binnacle/list/views/binnacle_list_body.dart';

class BinnacleListView extends StatelessWidget {
  const BinnacleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BinnacleListener.config(),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<BinnacleCubit>().getAll();
        },
        onDispose: () {},
        child: const BinnacleListBody(),
      ),
    );
  }
}
