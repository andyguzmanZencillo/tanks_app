import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/features/binnacle/list/cubit/binnacle_cubit.dart';
import 'package:tanks_app/features/binnacle/list/views/binnacle_list_view.dart';
import 'package:tanks_app/injection/injection.dart';

class BinnacleListPage extends StatelessWidget {
  const BinnacleListPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      builder: (context) => const BinnacleListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<BinnacleCubit>(),
        ),
      ],
      child: const BinnacleListView(),
    );
  }
}
