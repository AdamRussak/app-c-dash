import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LatestRun extends StatelessWidget {
  const LatestRun(
    this.screen,
  );
  final String screen;

  Icon statusIcon(String status) {
    var statusImage;
    if ("completed" == status) {
      statusImage = Icon(
        FontAwesomeIcons.thumbsUp,
        color: Colors.green[300],
      );
    } else if ("inProgress" == status) {
      statusImage = Icon(
        FontAwesomeIcons.running,
        color: Colors.blue[100],
      );
    } else {
      statusImage = Icon(
        FontAwesomeIcons.exclamationCircle,
        color: Colors.red[200],
      );
    }
    return statusImage;
  }

  Icon resultIcon(String status) {
    var statusImage;
    if ("succeeded" == status) {
      statusImage = Icon(
        FontAwesomeIcons.thumbsUp,
        color: Colors.green[300],
      );
    } else if ("inProgress" == status) {
      statusImage = Icon(
        FontAwesomeIcons.running,
        color: Colors.blue[100],
      );
    } else {
      statusImage = Icon(
        FontAwesomeIcons.exclamationCircle,
        color: Colors.red[200],
      );
    }
    return statusImage;
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        var list;
        if (screen == "build") {
          list = taskData.latestList[0];
        } else if (screen == "release") {
          list = taskData.releaseLatestList[0];
        } else if (screen == "test") {
          list = taskData.testLatestList[0];
        } else {}
        if (screen == "build") {
          String delimiter = "T";
          int lastIndex = list.finishTime == "inProgress"
              ? null
              : list.finishTime.indexOf(delimiter);
          return Container(
            // alignment: Alignment.topLeft,
            margin: EdgeInsets.all(2.5),
            decoration: BoxDecoration(
                color: index.isOdd ? Colors.grey[300] : Colors.grey[400],
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              children: [
                AppTile(
                  index: 0,
                  appName: list.appName,
                  branchName: list.branchName,
                  buildNumber: list.buildNumber,
                  buildResult: list.buildResult,
                  buildStatus: list.buildStatus,
                  finishTime: list.finishTime == "inProgress"
                      ? list.finishTime
                      : list.finishTime.substring(0, lastIndex),
                  appOs: list.appOs,
                  owner: list.owner,
                  platform: list.platform,
                )
              ],
            ),
          );
        } else if (screen == "release") {
          String delimiter = "T";
          int lastIndex = list.uploadDate.indexOf(delimiter);
          return Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.all(2.5),
            decoration: BoxDecoration(
                color: index.isOdd ? Colors.grey[300] : Colors.grey[400],
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              children: [
                AppTile(
                  index: 0,
                  appName: list.appName,
                  buildNumber: list.releaseID,
                  finishTime: list.uploadDate.substring(0, lastIndex),
                  appOs: list.appOs,
                  platform:
                      list.uploadVersion == "" ? "0.0.0" : list.uploadVersion,
                  branchName: "",
                  buildResult: "",
                  buildStatus: "",
                  owner: "",
                  screen: screen,
                )
              ],
            ),
          );
        } else if (screen == "test") {
          String delimiter = "T";
          int lastIndex = list.testDate.indexOf(delimiter);
          if (list.appName != "default") {
            return Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  color: index.isOdd ? Colors.grey[300] : Colors.grey[400],
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                children: [
                  AppTile(
                    index: 0,
                    appName: list.appName,
                    buildNumber: list.totalTests,
                    platform: list.appVersion == "" ? "0.0.0" : list.appVersion,
                    finishTime: list.testDate.substring(0, lastIndex),
                    appOs: list.appOs,
                    branchName: list.failedTests.toString(),
                    buildResult: list.state,
                    buildStatus: list.runStatus,
                    owner: list.passTests.toString(),
                    screen: screen,
                  )
                ],
              ),
            );
          } else {
            return Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  color: index.isOdd ? Colors.grey[300] : Colors.grey[400],
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                children: [
                  AppTile(
                    index: 0,
                    appName: "",
                    buildNumber: 0,
                    platform: "",
                    finishTime: "",
                    appOs: "",
                    branchName: "",
                    buildResult: "",
                    buildStatus: "",
                    owner: "",
                    screen: screen,
                  )
                ],
              ),
            );
          }
        } else {
          String delimiter = "T";
          int lastIndex = list.finishTime == "inProgress"
              ? null
              : list.finishTime.indexOf(delimiter);
          return Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.all(2.5),
            decoration: BoxDecoration(
                color: index.isOdd ? Colors.grey[300] : Colors.grey[400],
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              children: [
                AppTile(
                  index: 0,
                  appName: list.appName,
                  branchName: list.branchName,
                  buildNumber: list.buildNumber,
                  buildResult: list.buildResult,
                  buildStatus: list.buildStatus,
                  finishTime: list.finishTime == "inProgress"
                      ? list.finishTime
                      : list.finishTime.substring(0, lastIndex),
                  appOs: list.appOs,
                  owner: list.owner,
                  platform: list.platform,
                )
              ],
            ),
          );
        }
      },
    );
  }
}
