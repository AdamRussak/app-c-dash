import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:app_center_monitoring/models/app_list.dart';
import 'package:app_center_monitoring/models/parse_json.dart';
import 'package:app_center_monitoring/services/app_center.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TaskData extends ChangeNotifier {
  String formattedDate;
  Timer _timer;
  dynamic appName;
  int buttonSelect = 5;
  List buttonOptions = [
    1,
    5,
    10,
  ];
  dynamic ownerName;
  dynamic branchName;
  dynamic appsStatusList;
  bool isDataB = false;
  List<AppList> _appList = [];
  List<AppList> _latestList = [];
  // dynamic noBuild = ["Animo-Mobile-UI-Test", "Animo-Mobile-IOS"];
  String apiToken;
  bool tokenSet;

  int get taskCount {
    return _appList == null ? 0 : _appList.length;
  }

  UnmodifiableListView<AppList> get appList {
    return UnmodifiableListView(_appList);
  }

  UnmodifiableListView<AppList> get latestList {
    return UnmodifiableListView(_latestList);
  }

  void add(
      {String buildResult,
      String branchName,
      int buildNumber,
      String buildStatus,
      String finishTime,
      String appOs,
      String platform,
      String owner,
      String appName}) {
    _appList.add(
      AppList(
          buildResult: buildResult,
          branchName: branchName,
          buildNumber: buildNumber,
          buildStatus: buildStatus,
          finishTime: finishTime,
          appName: appName,
          owner: owner,
          platform: platform,
          appOs: appOs),
    );
  }

  void appCenterOwner(String apiKey) async {
    ownerName = await AppCenter().getOwners(apiKey).then(
        (response) => Ownerlist.fromJson(jsonDecode(response.toString())));
    var owner = ownerName.ownerMap[0].ownerName;
    appCenterApps(apiKey, owner);
  }

  void appCenterApps(String apiKey, String owner) async {
    _appList.clear();
    appName = await AppCenter()
        .getApps(apiKey, owner)
        .then((response) => Applist.fromJson(jsonDecode(response.toString())));
    appCenterBranches(apiToken, owner);
  }

  void updateRadioButton(int newTime) {
    buttonSelect = newTime;
    _timer.cancel();
    refreshTimer();
    notifyListeners();
  }

  void sortList() {
    _appList.sort((a, b) {
      return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
    });
    notifyListeners();
  }

  void appCenterParseBranches(String apiKey, dynamic app, String owner) async {
    var currentApp = app.appName;
    var currentOs = app.os;
    var currentPlatform = app.platform;
    var owner = ownerName.ownerMap[0].ownerName;
    branchName = await AppCenter().getBranches(currentApp, apiKey, owner).then(
        (response) => Branchlist.fromJson(jsonDecode(response.toString())));
    add(
        buildResult: branchName.appMap['buildResult'],
        branchName: branchName.appMap['branchName'],
        buildNumber: branchName.appMap['buildNumber'],
        buildStatus: branchName.appMap['buildStatus'],
        finishTime: branchName.appMap['finishTime'],
        appName: currentApp,
        platform: currentPlatform,
        owner: owner,
        appOs: currentOs);
    getLatest();
    sortList();
    taskCount;
    isData();
    notifyListeners();
  }

  void appCenterBranches(String apiKey, String owner) {
    for (var app in appName.appMap) {
      appCenterParseBranches(apiKey, app, owner);
    }
  }

  void getLatest() {
    dynamic max;
    if (_latestList.isEmpty) {
      _latestList.add(
        AppList(
            buildResult: "default",
            branchName: "default",
            buildNumber: 0,
            buildStatus: "default",
            finishTime: "1888-01-17T15:02:40.6543762Z",
            appName: "default",
            platform: "default",
            owner: "default",
            appOs: "default"),
      );
      max = _latestList[0];
    } else {
      max = _latestList[0];
    }
    _appList.forEach((e) {
      if (max.finishTime != "inProgress") {
        if (e.finishTime != "NotConfigured" && e.finishTime != "inProgress") {
          DateTime eDate = DateTime.parse(e.finishTime).toUtc();
          DateTime maxDate = DateTime.parse(max.finishTime).toUtc();
          if (eDate.toUtc().isAfter(maxDate.toUtc()) == true &&
                  e.finishTime != "NotConfigured" ||
              max.finishTime == "NotConfigured") {
            max = e;
            _latestList.isEmpty ? null : _latestList.clear();
            _latestList.add(
              AppList(
                  buildResult: max.buildResult,
                  branchName: max.branchName,
                  buildNumber: max.buildNumber,
                  buildStatus: max.buildStatus,
                  finishTime: max.finishTime,
                  appName: max.appName,
                  platform: max.platform,
                  owner: max.owner,
                  appOs: max.appOs),
            );
          }
        } else if (e.finishTime == "inProgress" &&
            max.finishTime != "inProgress") {
          max = e;
          _latestList.isEmpty ? null : _latestList.clear();
          _latestList.add(
            AppList(
                buildResult: max.buildResult,
                branchName: max.branchName,
                buildNumber: max.buildNumber,
                buildStatus: max.buildStatus,
                finishTime: max.finishTime,
                appName: max.appName,
                platform: max.platform,
                owner: max.owner,
                appOs: max.appOs),
          );
        }
      }
    });
    notifyListeners();
  }

  void isData() {
    if (_appList.length != taskCount) {
      isDataB = false;
    } else {
      isDataB = true;
    }
    notifyListeners();
  }

  void isTokenSet(bool newToken) {
    if (newToken == true) {
      tokenSet = true;
    } else {
      tokenSet = false;
      _timer.cancel();
    }
    notifyListeners();
  }

  void setApiToken(String newApiToken) {
    apiToken = newApiToken != null ? newApiToken : apiToken;
    isTokenSet(true);
    appCenterOwner(apiToken);
    refreshTimer();
    notifyListeners();
  }

  void refreshTimer() {
    _timer = Timer.periodic(Duration(minutes: buttonSelect), (timer) {
      appCenterApps(apiToken, ownerName.ownerMap[0].ownerName);
      _latestList.clear();
      lastRefresh();
    });
  }

  void lastRefresh() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd_kk:mm').format(now);
    notifyListeners();
  }
}
