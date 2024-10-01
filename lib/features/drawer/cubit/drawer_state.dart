part of 'drawer_cubit.dart';

class DrawerState extends Equatable {
  const DrawerState({
    this.listOption = const [],
    this.listOptionOriginal = const [],
  });

  final List<Option> listOption;
  final List<Option> listOptionOriginal;

  DrawerState copyWith({
    List<Option>? listOption,
    List<Option>? listOptionOriginal,
  }) {
    return DrawerState(
      listOption: listOption ?? this.listOption,
      listOptionOriginal: listOptionOriginal ?? this.listOptionOriginal,
    );
  }

  @override
  List<Object> get props => [
        listOption,
        listOptionOriginal,
      ];
}
