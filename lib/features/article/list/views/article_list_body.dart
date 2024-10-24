import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/core/util/extensions/extension_context.dart';
import 'package:tanks_app/core/util/extensions/extension_list.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';
import 'package:tanks_app/core/widgets/form/text_field_custom_pro.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_inherited.dart';
import 'package:tanks_app/features/article/create_update/views/create_update_view.dart';
import 'package:tanks_app/features/article/delete/cubit/article_delete_cubit.dart';
import 'package:tanks_app/features/article/delete/widget/article_delete_dialog.dart';
import 'package:tanks_app/features/article/list/cubit/article_list_cubit.dart';
import 'package:tanks_app/features/article/list/widgets/item_article_list.dart';

class ArticleListBody extends StatelessWidget {
  const ArticleListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final articleListCubit = context.read<ArticleListCubit>();
    final articleDeleteCubit = context.read<ArticleDeleteCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de artículos',
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
              children: [
                Expanded(
                  child: TextFieldCustomPro(
                    controller: ControllerField(),
                    label: 'Buscar...',
                    isLabelTitle: false,
                    onChanged: articleListCubit.search,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                AddButton(
                  onPressed: () {
                    context.pushContext(
                      BlocProvider.value(
                        value: articleListCubit,
                        child: const CreateUpdatePage(
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
              child: BlocBuilder<ArticleListCubit, ArticleListState>(
                builder: (context, state) {
                  final list = state.list;
                  return list.toListView(
                    itemSpacing: 10,
                    itemBuilder: (context, item, index) {
                      return ItemArticleList(
                        articleEntity: item,
                        ontalEdit: () {
                          articleListCubit.onChangeSelected(item);
                          context.pushContext(
                            BlocProvider.value(
                              value: articleListCubit,
                              child: const CreateUpdatePage(
                                typeOperation: TypeOperation.update,
                              ),
                            ),
                          );
                        },
                        ontapDelete: () {
                          articleListCubit.onChangeSelected(item);
                          showDialog<bool>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: articleListCubit,
                                  ),
                                  BlocProvider.value(
                                    value: articleDeleteCubit,
                                  ),
                                ],
                                child: const ArticleDeleteDialog(),
                              );
                            },
                          );
                        },
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

class AddButton extends StatelessWidget {
  const AddButton({
    required this.onPressed,
    super.key,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BlueStoneColors.blueStone700,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SearchButtonPro extends StatelessWidget {
  const SearchButtonPro({
    required this.onPressed,
    super.key,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BlueStoneColors.blueStone700,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    required this.onPressed,
    super.key,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BlueStoneColors.blueStone700,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GenericButton extends StatelessWidget {
  const GenericButton({
    required this.onPressed,
    required this.icon,
    super.key,
  });

  final void Function() onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: BlueStoneColors.blueStone700,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Icon(
          icon.icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
