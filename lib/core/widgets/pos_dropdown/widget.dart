import 'package:flutter/material.dart';
import 'package:tanks_app/core/widgets/pos_dropdown/dropdown_item.dart';

/// {@template pos_dropdown}
/// A [Widget] that renders a Dropdown Select.
/// {@endtemplate}
class PosDropdown extends StatefulWidget {
  /// {@macro pos_dropdown}
  const PosDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.width,
    this.borderSide = const BorderSide(),
    super.key,
  });

  /// Current selected value of the dropdown, could be empty
  final String value;

  /// List of strings with the selectable values
  final List<DropdownItem> items;

  /// The callback to be invoked when another value selected
  final void Function(String?) onChanged;

  /// Should be null if no specific size
  final double? width;

  final BorderSide borderSide;

  @override
  State<PosDropdown> createState() => _PosDropdownState();
}

class _PosDropdownState extends State<PosDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: widget.borderSide,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            onChanged: (value) {
              widget.onChanged(value);
              FocusScope.of(context).nextFocus();
            },
            value: widget.value.isNotEmpty ? widget.value : null,
            style: const TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 20,
            hint: const Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Seleccionar',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            items: widget.items.map((item) {
              return DropdownMenuItem<String>(
                value: item.value,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.text,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class PosDropdown2<T> extends StatefulWidget {
  /// {@macro pos_dropdown}
  const PosDropdown2({
    required this.value,
    required this.items,
    required this.onChanged,
    this.width,
    this.borderSide = const BorderSide(),
    super.key,
  });

  /// Current selected value of the dropdown, could be empty
  final T value;

  /// List of strings with the selectable values
  final List<DropdownItem2<T>> items;

  /// The callback to be invoked when another value selected
  final void Function(T) onChanged;

  /// Should be null if no specific size
  final double? width;

  final BorderSide borderSide;

  @override
  State<PosDropdown2<T>> createState() => _PosDropdownState2<T>();
}

class _PosDropdownState2<T> extends State<PosDropdown2<T>> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: widget.borderSide,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<DropdownItem2<T>>(
            isExpanded: true,
            isDense: true,
            onChanged: (value) {
              widget.onChanged(value!.item);
              FocusScope.of(context).nextFocus();
            },
            value: widget.items.firstWhere(
              (element) => element.item == widget.value,
            ),
            style: const TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 20,
            hint: const Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Seleccionar',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            items: widget.items.map((item) {
              return DropdownMenuItem<DropdownItem2<T>>(
                value: item,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.text,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
