import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData icon;
  final IconData? iconSufix;
  final String empty;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool textArea;
  final int maxLines;
  final Function(String value)? onChanged;
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.label = '',
    required this.icon,
    this.iconSufix,
    this.empty = 'Por favor llene este campo',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textArea = false,
    this.maxLines = 4,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelStyle: const TextStyle(fontSize: 13),
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: Icon(iconSufix),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(18.0),
          ),
        ),
      ),
      keyboardType: textArea ? TextInputType.multiline : keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return empty;
        }
        return null;
      },
      maxLines: textArea ? maxLines : 1,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
