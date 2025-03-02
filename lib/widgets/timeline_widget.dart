import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TimelineModel {
  final String label;
  final IconData icon;

  TimelineModel({required this.label, required this.icon});

  TimelineModel.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        icon = json['icon'];

  static List<TimelineModel> fromListJson(List<dynamic> json) {
    return json.map((e) => TimelineModel.fromJson(e)).toList();
  }
}

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({
    super.key,
    required this.list,
    required this.status,
    this.itemExtent = 100.0,
    this.height = 125.0,
  });

  final List<TimelineModel> list;
  final int status;
  final double itemExtent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: Timeline.tileBuilder(
        shrinkWrap: true,
        theme: TimelineThemeData(
          indicatorTheme: const IndicatorThemeData(size: 50.0),
          direction: Axis.horizontal,
          connectorTheme: const ConnectorThemeData(space: 30.0, thickness: 8.0),
        ),
        builder: TimelineTileBuilder.connected(
          itemExtentBuilder: (_, index) => itemExtent,
          connectionDirection: ConnectionDirection.before,
          itemCount: list.length,
          contentsBuilder: (context, index) => Text(list[index].label),
          connectorBuilder: (_, index, __) => DecoratedLineConnector(
            decoration: BoxDecoration(
              color: index < status
                  ? Theme.of(context).primaryColor
                  : Colors.grey[400],
            ),
          ),
          indicatorBuilder: (contextIn, index) => DotIndicator(
            color: index < status
                ? Theme.of(context).primaryColor
                : Colors.grey[400],
            child: Icon(
              list[index].icon,
              size: 24,
              color: index < status ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
