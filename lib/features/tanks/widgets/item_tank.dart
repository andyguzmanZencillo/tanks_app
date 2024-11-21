import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:tank_repository/features/article/article.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';

class ItemTank extends StatelessWidget {
  const ItemTank({
    required this.tanksEntity,
    required this.onTap,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.onTable,
    this.salesCenterEntity,
    this.articleEntity,
    this.consoleEntity,
    super.key,
  });
  final TanksEntity tanksEntity;
  final SalesCenterEntity? salesCenterEntity;
  final ConsoleEntity? consoleEntity;
  final ArticleEntity? articleEntity;
  final void Function() onTap;
  final void Function() onTapEdit;
  final void Function() onTapDelete;
  final void Function() onTable;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(23, 187, 187, 187),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(87, 158, 158, 158),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: BlueStoneColors.blueStone600,
                child: Icon(
                  Icons.oil_barrel,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  tanksEntity.text,
                  style: const TextStyle(
                    color: BlueStoneColors.blueStone900,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.keyboard_arrow_right_sharp,
                  size: 25,
                  color: BlueStoneColors.blueStone900,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          if (articleEntity != null)
            Row(
              children: [
                const Icon(
                  Icons.article,
                  size: 15,
                  color: BlueStoneColors.blueStone700,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  articleEntity!.articulo,
                  style: const TextStyle(color: BlueStoneColors.blueStone900),
                ),
              ],
            ),
          if (salesCenterEntity != null)
            Row(
              children: [
                const Icon(
                  Icons.shopping_basket_rounded,
                  size: 15,
                  color: BlueStoneColors.blueStone700,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  salesCenterEntity!.centroVenta,
                  style: const TextStyle(color: BlueStoneColors.blueStone900),
                ),
              ],
            ),
          if (consoleEntity != null)
            Row(
              children: [
                const Icon(
                  Icons.monitor,
                  size: 15,
                  color: BlueStoneColors.blueStone700,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  consoleEntity!.consola,
                  style: const TextStyle(color: BlueStoneColors.blueStone900),
                ),
              ],
            ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 130,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BlueStoneColors.blueStone500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(1),
                  ),
                  onPressed: onTable,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tabla de aforo',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(
                        FluentIcons.open_12_regular,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onTapEdit,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236),
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
                    onTap: onTapDelete,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236),
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
