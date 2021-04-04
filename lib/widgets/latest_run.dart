import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LatestRun extends StatelessWidget {
  Image osIconSelector(String os) {
    var imageSet;
    if ("iOS" == os) {
      imageSet = Image.asset(
        'assets/os/iOS.png',
        height: 50,
        width: 50,
      );
    } else if ("Android" == os) {
      imageSet = Image.asset(
        'assets/os/android.png',
        height: 50,
        width: 50,
      );
    } else if ("Windows" == os) {
      imageSet = Image.asset(
        'assets/os/windows.png',
        height: 50,
        width: 50,
      );
    }
    return imageSet;
  }

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
        var list = taskData.latestList[0];
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
      },
    );
  }
}
