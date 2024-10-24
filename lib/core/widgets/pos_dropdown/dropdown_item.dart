class DropdownItem {
  const DropdownItem({
    required this.value,
    required this.text,
  });

  final String value;
  final String text;
}

class DropdownItem2<T> {
  const DropdownItem2({
    required this.value,
    required this.text,
    required this.item,
  });

  final String value;
  final String text;
  final T item;
}
