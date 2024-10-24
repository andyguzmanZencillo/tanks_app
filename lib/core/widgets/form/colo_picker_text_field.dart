import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tanks_app/core/util/form/controllers/controllers.dart';

class ColorPickerTextField extends StatefulWidget {
  const ColorPickerTextField({required this.controller, super.key});
  final ControllerField controller;

  @override
  ColorPickerTextFieldState createState() => ColorPickerTextFieldState();
}

class ColorPickerTextFieldState extends State<ColorPickerTextField> {
  Color _selectedColor = Colors.orange;

  @override
  void initState() {
    super.initState();
    if (widget.controller.getValue().isEmpty) {
      widget.controller.setValue(_colorToHex(_selectedColor));
    } else {
      widget.controller.setValue(
        _colorToHex(hexToColor(widget.controller.getValue())),
      );
      _selectedColor = hexToColor(widget.controller.getValue());
    }
  }

  Color hexToColor(String hexColor) {
    final validHexPattern = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');

    if (!validHexPattern.hasMatch(hexColor)) {
      return _selectedColor;
    }

    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
    } catch (e) {
      return _selectedColor;
    }
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  void _openColorPicker() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona el color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              hexInputBar: true,
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                  widget.controller.setValue(
                    _colorToHex(
                      _selectedColor,
                    ),
                  );
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Seleccionar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Color',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: widget.controller.textEditingController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            filled: true,
            prefixIcon: IconButton(
              onPressed: () {},
              icon: InkWell(
                onTap: _openColorPicker,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _selectedColor, // Color de fondo del container
                    borderRadius:
                        BorderRadius.circular(10), // Bordes redondeados
                  ),
                ),
              ),
            ),
            fillColor: const Color.fromARGB(255, 233, 235, 236),
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 117, 117, 117),
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
          ),
          readOnly: true, // Solo lectura
          onTap: _openColorPicker, // Abre el selector al tocar el campo
        ),
      ],
    );
  }
}
