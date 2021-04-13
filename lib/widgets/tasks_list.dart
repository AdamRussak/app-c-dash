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
              int lastIndex = task.finishTime == "NotConfigured" ||
                      task.finishTime == "inProgress"
                  ? null
                  : task.finishTime.indexOf(delimiter);

              return Container(
                margin: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    color: index.isOdd ? Colors.grey[300] : Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: AppTile(
                  index: index,
                  appName: task.appName,
                  branchName: task.branchName,
                  buildNumber: task.buildNumber,
                  buildResult: task.buildResult,
                  buildStatus: task.buildStatus,
                  finishTime: task.finishTime == "NotConfigured" ||
                          task.finishTime == "inProgress"
                      ? task.finishTime
                      : task.finishTime.substring(0, lastIndex),
                  appOs: task.appOs,
                  owner: task.owner,
                  platform: task.platform,
                ),
              );
            },
            itemCount: taskData != null ? taskData.buildAppCount : 0,
          ),
        );
      },
    );
  }
}
