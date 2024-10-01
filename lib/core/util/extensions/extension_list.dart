import 'package:flutter/material.dart';

extension ListViewBuilderExtension<T> on List<T> {
  Widget toListView({
    required Widget Function(BuildContext context, T item, int index)
        itemBuilder,
    double itemSpacing = 0, // Espacio entre elementos
  }) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            itemBuilder(context, this[index], index),
            if (itemSpacing > 0 && index < length - 1)
              SizedBox(height: itemSpacing),
          ],
        );
      },
    );
  }
}
