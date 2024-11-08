import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/helpers/user_device/cubit/user_device_cubit.dart';
import 'package:tanks_app/core/util/enums/enums.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/features/profile/perfil/widgets/delete_device_dialog.dart';
import 'package:tanks_app/features/sales_center/delete/helpers/sales_center_delete_listener.dart';

class ConfigDevices extends StatelessWidget {
  const ConfigDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Mis dispositivos configurados',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<UserDeviceCubit, UserDeviceState>(
            buildWhen: (previous, current) => previous.list != current.list,
            builder: (context, state) {
              if (state.status == GeneralStatus.loading) {
                return const Center(
                  child: Text(
                    'Buscando dispositivos..',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              if (state.list.isNotEmpty) {
                return state.list.toListViewItem(
                  isWrap: true,
                  itemSpacing: 10,
                  itemBuilder: (item) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: BlueStoneColors.blueStone200,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.phone_android),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              item.dispositivo,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<UserDeviceCubit>().onChangeSelected(
                                    item,
                                  );
                              context.show(
                                BlocProvider.value(
                                  value: context.read<UserDeviceCubit>(),
                                  child: const DeleteDeviceDialog(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text(
                  'No hay dispositos configuradas',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
