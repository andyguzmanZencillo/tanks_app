import 'package:flutter/material.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class ItemArticleList2 extends StatelessWidget {
  const ItemArticleList2({
    required this.articleEntity,
    required this.ontalEdit,
    required this.ontapDelete,
    super.key,
  });
  final ArticleEntity articleEntity;
  final void Function() ontalEdit;
  final void Function() ontapDelete;

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String hexColor) {
      final validHexPattern = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');

      if (!validHexPattern.hasMatch(hexColor)) {
        return Colors.grey;
      }

      try {
        return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
      } catch (e) {
        return Colors.grey;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 248, 248),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(8, 158, 158, 158),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: hexToColor(articleEntity.color),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articleEntity.articulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: BlueStoneColors.blueStone950,
                  ),
                ),
                Text(
                  articleEntity.descripcion,
                  style: const TextStyle(
                    color: BlueStoneColors.blueStone900,
                  ),
                ),
                Text(
                  'Codigo: ${articleEntity.code}',
                  style: const TextStyle(
                    color: BlueStoneColors.blueStone900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /*PopupMenuButton(
                icon: Icon(
                  color: Colors.grey[700],
                  Icons.more_horiz,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'edit',
                      onTap: ontalEdit,
                      child: const Text('Editar'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      onTap: ontapDelete,
                      child: const Text('Eliminar'),
                    ),
                  ];
                },
              ),*/
              Text(
                r'$' + articleEntity.precio.toStringAsFixed(2),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: BlueStoneColors.blueStone900,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: ontalEdit,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: BlueStoneColors.blueStone700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: ontapDelete,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
