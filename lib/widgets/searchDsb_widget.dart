import 'package:flutter/material.dart';

class SearchDsbWidget extends StatelessWidget {
  final String hint;
  final IconData icon;
  final List<Widget> actions;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const SearchDsbWidget({
    super.key,
    this.hint = 'Buscar...',
    this.icon = Icons.search,
    this.actions = const [],
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint,
                  prefixIcon: Icon(icon),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: onChanged,
              ),
            ),
            const SizedBox(width: 16),
            ...actions,
          ],
        ),
      ),
    );
  }
}
