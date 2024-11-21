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

  Widget toListViewSepared({
    required Widget Function(
      BuildContext context,
      T item,
      int index,
    ) itemBuilder,
    bool isWrap = false,
    Color dividerColor = Colors.grey,
    double dividerThickness = 1.0,
    EdgeInsets dividerMargin = const EdgeInsets.symmetric(horizontal: 8),
  }) {
    return ListView.builder(
      shrinkWrap: isWrap,
      itemCount: length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            itemBuilder(context, this[index], index),
            if (index < length - 1)
              Padding(
                padding: dividerMargin,
                child: Divider(
                  color: dividerColor,
                  thickness: dividerThickness,
                ),
              ),
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
