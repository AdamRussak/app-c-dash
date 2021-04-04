import 'package:app_center_monitoring/utilities/const.dart';
import 'package:app_center_monitoring/widgets/app_tile_settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppTile extends StatelessWidget {
  final String buildResult;
  final String branchName;
  final int buildNumber;
  final String buildStatus;
  final String finishTime;
  final String appName;
  final String owner;
  final String appOs;
  final String platform;
  final int index;
  AppTile(
      {this.appName,
      this.branchName,
      this.index,
      this.buildNumber,
      this.buildResult,
      this.buildStatus,
      this.owner,
      this.appOs,
      this.platform,
      this.finishTime});
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
    } else if ("NotConfigured" == status) {
      statusImage = Icon(
        FontAwesomeIcons.exclamationCircle,
        color: Colors.blueAccent[200],
      );
    } else {
      statusImage = Icon(
        FontAwesomeIcons.exclamationTriangle,
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
    } else if ("NotConfigured" == status) {
      statusImage = Icon(
        FontAwesomeIcons.exclamationCircle,
        color: Colors.blueAccent[200],
      );
    } else {
      statusImage = Icon(
        FontAwesomeIcons.exclamationCircle,
        color: Colors.red[200],
      );
    }
    return statusImage;
  }

  Icon osIconSelector(String os) {
    var imageSet;
    if ("iOS" == os) {
      imageSet = Icon(
        FontAwesomeIcons.apple,
        color: Colors.black,
        size: KIconSize,
      );
    } else if ("Android" == os) {
      imageSet = Icon(
        FontAwesomeIcons.android,
        color: Colors.green,
        size: KIconSize,
      );
    } else if ("Windows" == os) {
      imageSet = Icon(
        FontAwesomeIcons.windows,
        color: Colors.blue,
        size: KIconSize,
      );
    }
    return imageSet;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      contentPadding: EdgeInsets.all(20.0),
      title: Container(
        alignment: Alignment.centerLeft,
        child: FloatingActionButton.extended(
          tooltip: "Go to $appName",
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          foregroundColor: Colors.black,
          backgroundColor: index.isOdd ? Colors.grey[300] : Colors.grey[400],
          onPressed: () {
            launch(
                "https://appcenter.ms/orgs/$owner/apps/$appName/build/Branches");
            print(appName);
          },
          label: Text(
            appName,
            style: KAppNameTextStyle,
          ),
        ),
      ),
      leading: osIconSelector(appOs),
      subtitle: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            Center(
              child: AppTileSettings(
                rowDeiscriiption: Text(
                  "Build ID:",
                  style: KHeaderStyle,
                ),
                tileInput: Text(
                  buildNumber.toString(),
                  style: KListTextStyle,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Center(
              child: AppTileSettings(
                rowDeiscriiption: Text(
                  "Date:",
                  style: KHeaderStyle,
                ),
                tileInput: finishTime == "inProgress"
                    ? statusIcon(finishTime)
                    : Text(
                        finishTime,
                        style: KListTextStyle,
                      ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Center(
              child: AppTileSettings(
                rowDeiscriiption: Text(
                  "Status:",
                  style: KHeaderStyle,
                ),
                tileInput: statusIcon(buildStatus),
              ),
            ),
          ]),
          TableRow(
            children: [
              Center(
                child: AppTileSettings(
                  rowDeiscriiption: Text(
                    "Platform:",
                    style: KHeaderStyle,
                  ),
                  tileInput: Text(
                    platform,
                    style: KListTextStyle,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 10.0,
                ),
              ),
              Center(
                child: AppTileSettings(
                  rowDeiscriiption: Text(
                    "Branch:",
                    style: KHeaderStyle,
                  ),
                  tileInput: Text(
                    branchName,
                    style: KListTextStyle,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 10.0,
                ),
              ),
              Center(
                child: AppTileSettings(
                  rowDeiscriiption: Text(
                    "Build Result:",
                    style: KHeaderStyle,
                  ),
                  tileInput: buildResult == null
                      ? resultIcon(" ")
                      : resultIcon(buildResult),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
