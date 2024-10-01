import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option.dart';
import 'package:tanks_app/features/drawer/helper/drawer_option_config.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(const DrawerState());

  void onChangeOptions(List<Option> optionList) {
    emit(
      state.copyWith(
        listOption: optionList,
        listOptionOriginal: optionList,
      ),
    );
  }

  void onDeactivate(OptionType type) {
    final options = [...state.listOption];
    final index = options.indexWhere((option) => option.type == type);
    if (index != -1) {
      options[index] = options[index].copyWith(isActive: false);
    }
    emit(state.copyWith(listOption: options));
  }

  void onActive(OptionType type) {
    final options = [...state.listOption];
    final index = options.indexWhere((option) => option.type == type);
    if (index != -1) {
      options[index] = options[index].copyWith(isActive: true);
    }
    emit(state.copyWith(listOption: options));
  }

  void verificatePermissions(Map<OptionType, bool> permissions) {
    final options = [...state.listOption];

    final result = options.map((e) {
      final isActive = permissions[e.type];
      return e.copyWith(isPermission: isActive);
    }).toList();

    emit(state.copyWith(listOption: result));
  }
}
