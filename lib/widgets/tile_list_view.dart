import 'package:app_center_monitoring/widgets/task_tile.dart';
import 'package:flutter/material.dart';

class TileListView extends StatelessWidget {
  const TileListView({
    @required this.screen,
    @required this.totalCount,
    @required this.screenList,
  });

  final String screen;
  final int totalCount;
  final List screenList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          final task = screenList[index];
          if (screen == "build") {
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
                appOs: task.appOs,
                branchName: task.failedTests.toString(),
                buildResult: task.state,
                buildStatus: task.runStatus,
                owner: task.passTests.toString(),
                screen: screen,
              ),
            );
          } else {
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
        itemCount: totalCount,
      ),
    );
  }
}
