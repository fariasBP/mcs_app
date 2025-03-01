import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final void Function()? onBack;
  const HeaderWidget({
    super.key,
    required this.title,
    this.actions = const [],
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 50,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: onBack != null ? 14 : 0),
            child: onBack != null
                ? InkWell(
                    onTap: onBack,
                    child: const Icon(Icons.arrow_back_ios_new, size: 22))
                : null,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            children: actions,
          ),
        ],
      ),
    );
  }
}
