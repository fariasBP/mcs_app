import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final int index;
  final String title;
  final Widget? leading;
  final Widget? leadingDefault;
  final List<Widget> subtitles;
  final List<Widget> actions;
  final Function()? onTap;
  const TileWidget({
    super.key,
    required this.index,
    required this.title,
    this.subtitles = const [],
    this.actions = const [],
    this.onTap,
    this.leading,
    this.leadingDefault,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading ?? leadingDefault,
      title: Text(title),
      subtitle: subtitles.isEmpty
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subtitles,
            ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
      // isThreeLine: true,
      onTap: onTap != null ? onTap : null,
    );
  }
}
