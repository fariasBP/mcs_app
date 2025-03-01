import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  static const int DEFAULT = 0;
  static const int NORMAL = 1;
  static const int SUCCESS = 2;
  static const int DANGER = 3;
  static const int WARNING = 4;
  static const int INFO = 5;
  final int style;
  final String label;
  final IconData? icon;
  final Function()? onPressed;
  final bool isLoading;
  final double height;
  const ButtonWidget({
    super.key,
    this.style = DEFAULT,
    required this.label,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.height = 35,
  });

  ButtonStyle _getStyle(BuildContext context) {
    switch (style) {
      case NORMAL:
        return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        );
      case SUCCESS:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        );
      case DANGER:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        );
      case WARNING:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        );
      case INFO:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        );
      case DEFAULT:
        return ElevatedButton.styleFrom();
      default:
        return ElevatedButton.styleFrom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: icon != null ? Icon(icon, size: 20) : Container(),
        label: isLoading
            ? const LinearProgressIndicator()
            : Text(label, style: const TextStyle(fontSize: 13)),
        style: _getStyle(context),
      ),
    );
  }
}
