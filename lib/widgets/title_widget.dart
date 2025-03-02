import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final bool question;
  const TitleWidget({super.key, required this.title, this.question = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          question
              ? Icon(Icons.info_outline, color: Colors.grey[600], size: 20)
              : Container(),
        ],
      ),
    );
  }
}
