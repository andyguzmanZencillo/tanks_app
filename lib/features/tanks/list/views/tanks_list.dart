import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/tanks/create_update/views/upsert_tanks_page.dart';
import 'package:tanks_app/features/tanks/detail/views/detail_tank.dart';
import 'package:tanks_app/features/tanks/list/cubit/tanks_cubit.dart';
import 'package:tanks_app/features/tanks/list/helpers/list_tanks_listener.dart';
import 'package:tanks_app/features/tanks/widgets/item_tank.dart';
import 'package:tanks_app/injection/injection.dart';

class TanksListPage extends StatelessWidget {
  const TanksListPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      builder: (context) => const TanksListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TanksCubit>(),
      child: const TanksListView(),
    );
  }
}

class TanksListView extends StatelessWidget {
  const TanksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ListTanksListener.tanks(),
      ],
      child: FullWidgetGeneric(
        onInit: () {
          context.read<TanksCubit>().getAll();
        },
        onDispose: () {},
        child: const TanksListBody(),
      ),
    );
  }
}

class TanksListBody extends StatelessWidget {
  const TanksListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final tanskCubit = context.read<TanksCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanques'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                context
                    .pushResult<bool?>(
                  UpsertTanksPage.route(
                    typeOperation: TypeOperation.create,
                  ),
                )
                    .then((value) {
                  if (value == null || value == false) {
                    return;
                  }
                  context.read<TanksCubit>().getAll();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 170, 25),
                padding: const EdgeInsets.symmetric(
                  //vertical: 15,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Crear tanque',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<TanksCubit, TanksState>(
                builder: (context, state) {
                  final list = state.tanks;
                  return list.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemTank(
                        tanksEntity: item,
                        onTap: () {
                          tanskCubit.changeSelected(item);
                          context.pushResult<bool?>(
                            DetailTankView.route(tanksCubit: tanskCubit),
                          );
                        },
                        onTapEdit: () {
                          context
                              .pushResult<bool?>(
                            UpsertTanksPage.route(
                              typeOperation: TypeOperation.update,
                              tanksEntity: item,
                            ),
                          )
                              .then((value) {
                            if (value == null || value == false) {
                              return;
                            }
                            context.read<TanksCubit>().getAll();
                          });
                        },
                        onTapDelete: () {},
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
