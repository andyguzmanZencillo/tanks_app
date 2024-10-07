import 'package:flutter/material.dart';

extension ListViewBuilderExtension<T> on List<T> {
  Widget toListView({
    required Widget Function(BuildContext context, T item, int index)
        itemBuilder,
    double itemSpacing = 0,
    bool isWrap = false,
  }) {
    return ListView.builder(
      //clipBehavior: Clip.none,
      shrinkWrap: isWrap,
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

  Widget toListViewItem({
    required Widget Function(T item) itemBuilder,
    double itemSpacing = 0,
    bool isWrap = false,
  }) {
    return ListView.builder(
      //clipBehavior: Clip.none,
      shrinkWrap: isWrap,
      itemCount: length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            itemBuilder(
              this[index],
            ),
            if (itemSpacing > 0 && index < length - 1)
              SizedBox(height: itemSpacing),
          ],
        );
      },
    );
  }
}
