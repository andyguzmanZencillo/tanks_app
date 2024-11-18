import 'package:flutter/material.dart';
import 'package:tank_repository/features/article/entity/article_entity.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class ItemArticleList extends StatelessWidget {
  const ItemArticleList({
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlueStoneColors.blueStone200,
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: CircleAvatar(
          backgroundColor: BlueStoneColors.blueStone600,
          child: Icon(
            Icons.circle,
            size: 30,
            color: hexToColor(articleEntity.color),
          ),
        ),
        title: Text(
          articleEntity.articulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: BlueStoneColors.blueStone950,
          ),
        ),
        subtitle: Text(
          '${articleEntity.descripcion}\nPrecio: \$${articleEntity.precio.toStringAsFixed(2)}',
          style: const TextStyle(
            color: BlueStoneColors.blueStone900,
          ),
        ),
        isThreeLine: true,
        trailing: PopupMenuButton(
          icon: const Icon(
            Icons.more_vert,
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
        ),
      ),
    );
  }
}
