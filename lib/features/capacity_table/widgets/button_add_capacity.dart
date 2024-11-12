import 'package:flutter/material.dart';

class ButtonAddCapacity extends StatelessWidget {
  const ButtonAddCapacity({required this.onPressed, super.key});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 170, 25),
        padding: const EdgeInsets.symmetric(
          //vertical: 15,
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Editar',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
