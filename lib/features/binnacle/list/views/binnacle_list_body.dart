import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/features/binnacle/entity/binnacle_entity.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/features/binnacle/list/cubit/binnacle_cubit.dart';
import 'package:tanks_app/features/binnacle/list/widget/item_binnacle.dart';

class BinnacleListBody extends StatelessWidget {
  const BinnacleListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BinnacleCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bitacoras'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: BlocSelector<BinnacleCubit, BinnacleState,
                  List<BinnacleEntity>>(
                selector: (state) {
                  return state.list;
                },
                builder: (context, configurations) {
                  return configurations.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemBinnacle(
                        binnacleEntity: item,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
