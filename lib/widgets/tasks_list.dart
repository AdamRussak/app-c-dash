import 'package:flutter/material.dart';
import 'package:app_center_monitoring/models/task_data.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return Container(
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) {
              final task = taskData.appList[index];

              String delimiter = "T";
              int lastIndex = task.finishTime == "NotConfigured"
                  ? null
                  : task.finishTime.indexOf(delimiter);

              return Center(
                child: AppTile(
                  appName: task.appName,
                  branchName: task.branchName,
                  buildNumber: task.buildNumber,
                  buildResult: task.buildResult,
                  buildStatus: task.buildStatus,
                  finishTime: task.finishTime == "NotConfigured"
                      ? task.finishTime
                      : task.finishTime.substring(0, lastIndex),
                  appOs: task.appOs,
                  platform: task.platform,
                ),
              );
            },
            itemCount: taskData != null ? taskData.taskCount : 0,
          ),
        );
      },
    );
  }
}
