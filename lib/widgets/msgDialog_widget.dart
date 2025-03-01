import 'package:flutter/material.dart';

class MsgDialogWidget extends StatelessWidget {
  final String msg;
  final int typeMsg;
  static const int DEFAULT = 0;
  static const int NORMAL = 1;
  static const int SUCCESS = 2;
  static const int DANGER = 3;
  static const int WARNING = 4;
  static const int INFO = 5;

  const MsgDialogWidget({
    super.key,
    required this.msg,
    this.typeMsg = DEFAULT,
  });

  Widget _getMsg() {
    TextStyle stl;
    switch (typeMsg) {
      case NORMAL:
        stl = const TextStyle(color: Colors.black);
        break;
      case SUCCESS:
        stl = const TextStyle(color: Colors.green);
        break;
      case DANGER:
        stl = const TextStyle(color: Colors.red);
        break;
      case WARNING:
        stl = const TextStyle(color: Colors.orange);
        break;
      case INFO:
        stl = const TextStyle(color: Colors.blue);
        break;
      default:
        stl = const TextStyle(color: Colors.black);
    }
    return Text(msg, style: stl);
  }

  Color _getBackgroundColor() {
    switch (typeMsg) {
      case NORMAL:
        return Colors.white;
      case SUCCESS:
        return Colors.green;
      case DANGER:
        return Colors.red;
      case WARNING:
        return Colors.orange;
      case INFO:
        return Colors.blue;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: _getMsg(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
