import 'package:app_center_monitoring/widgets/tile_list_view.dart';
import 'package:flutter/material.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    @required this.screen,
    @required this.totalCount,
    @required this.screenList,
  });
  final String screen;
  final int totalCount;
  final List screenList;
  @override
  Widget build(BuildContext context) {
    return TileListView(
      screenList: screenList,
      screen: screen,
      totalCount: totalCount,
    );
  }
}
