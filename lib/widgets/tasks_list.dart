import 'package:flutter/material.dart';
import 'package:app_center_monitoring/models/task_data.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({@required this.screen, @required this.totalCount});
  final String screen;
  final int totalCount;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return Container(
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) {
              if (screen == "build") {
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
                    screen: screen,
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
              } else if (screen == "release") {
                final task = taskData.releaseList[index];
                String delimiter = "T";
                int lastIndex = task.uploadDate.indexOf(delimiter);
                return Container(
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: index.isOdd ? Colors.grey[300] : Colors.grey[400],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: AppTile(
                    index: index,
                    appName: task.appName,
                    buildNumber: task.releaseID,
                    platform:
                        task.uploadVersion == "" ? "0.0.0" : task.uploadVersion,
                    finishTime: task.uploadDate.substring(0, lastIndex),
                    appOs: task.appOs,
                    branchName: "",
                    buildResult: "",
                    buildStatus: "",
                    owner: "",
                    screen: screen,
                  ),
                );
              } else if (screen == "test") {
                final task = taskData.testAppList[index];
                String delimiter = "T";
                int lastIndex = task.testDate.indexOf(delimiter);
                return Container(
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: index.isOdd ? Colors.grey[300] : Colors.grey[400],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: AppTile(
                    index: index,
                    appName: task.appName,
                    buildNumber: task.totalTests,
                    platform: task.appVersion == "" ? "0.0.0" : task.appVersion,
                    finishTime: task.testDate.substring(0, lastIndex),
                    appOs: task.appName,
                    branchName: task.totalTests.toString(),
                    buildResult: task.state,
                    buildStatus: task.runStatus,
                    owner: "",
                    screen: screen,
                  ),
                );
              } else {
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
              }
            },
            itemCount: taskData != null ? totalCount : 0,
          ),
        );
      },
    );
  }
}
