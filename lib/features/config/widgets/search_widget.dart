import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    required this.searchController,
    required this.onSearch,
    super.key,
  });
  final TextEditingController searchController;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Campo de texto para la búsqueda
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Buscar...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Botón de búsqueda
        ElevatedButton(
          onPressed: onSearch,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 243, 170, 25),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
