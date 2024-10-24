import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/util/full_widget_generics.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/list/views/article_list_body.dart';
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
        title: const Text(
          'Tanques',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFieldCustomPro(
                    controller: ControllerField(),
                    label: 'Buscar...',
                    isLabelTitle: false,
                    onChanged: tanskCubit.search,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                AddButton(
                  onPressed: () {
                    context.pushContext(
                      BlocProvider.value(
                        value: tanskCubit,
                        child: const UpsertTanksPage(
                          typeOperation: TypeOperation.create,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<TanksCubit, TanksState>(
                builder: (context, state) {
                  final list = state.list;
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
                          context.pushComplete(
                            const UpsertTanksPage(
                              typeOperation: TypeOperation.update,
                            ),
                          );
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
