import 'package:flutter/material.dart';
import 'package:tank_repository/tank_repository.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    Widget info(Icon icon, String title, String text) {
      return Row(
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
          ),
          const Spacer(),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Información',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          info(
            Icon(
              Icons.person_outline_outlined,
              color: Colors.grey[700],
            ),
            'Nombre',
            user.name,
          ),
          const SizedBox(
            height: 10,
          ),
          info(
            Icon(
              Icons.email_outlined,
              color: Colors.grey[700],
            ),
            'Usuario/Correo',
            user.login,
          ),
        ],
      ),
    );
  }
}
