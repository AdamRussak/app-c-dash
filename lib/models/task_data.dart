import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:app_center_monitoring/models/app_list.dart';
import 'package:app_center_monitoring/models/parse_json.dart';
import 'package:app_center_monitoring/services/app_center.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

//TODO: find and fix count and resoult inconsistance
class TaskData extends ChangeNotifier {
  String formattedDate;
  Timer _timer;
  dynamic appName;
  dynamic releaseCheck;
  dynamic testCheck;
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
  List<ReleaseList> _releaseList = [];

  List<ReleaseList> _releaseLatestList = [];
  List<TestList> _testList = [];
  List<TestList> _testLatestList = [];
  List<AppList> _latestList = [];
  // dynamic noBuild = ["Animo-Mobile-UI-Test", "Animo-Mobile-IOS"];
  String apiToken;
  bool tokenSet;

  int get buildAppCount {
    return _appList == null ? 0 : _appList.length;
  }

  int get releaseAppCount {
    return _releaseList == null ? 0 : _releaseList.length;
  }

  int get testAppCount {
    return _testList == null ? 0 : _testList.length;
  }

  UnmodifiableListView<AppList> get appList {
    return UnmodifiableListView(_appList);
  }

  UnmodifiableListView<ReleaseList> get releaseList {
    return UnmodifiableListView(_releaseList);
  }

  UnmodifiableListView<TestList> get testAppList {
    return UnmodifiableListView(_testList);
  }

  UnmodifiableListView<AppList> get latestList {
    return UnmodifiableListView(_latestList);
  }

  UnmodifiableListView<ReleaseList> get releaseLatestList {
    return UnmodifiableListView(_releaseLatestList);
  }

  UnmodifiableListView<TestList> get testLatestList {
    return UnmodifiableListView(_testLatestList);
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
    notifyListeners();
  }

  void appCenterOwner(String apiKey) async {
    ownerName = await AppCenter().getOwners(apiKey).then(
        (response) => Ownerlist.fromJson(jsonDecode(response.toString())));
    var owner = ownerName.ownerMap[0].ownerName;
    appCenterApps(apiKey, owner);
  }

  void appCenterApps(String apiKey, String owner) async {
    _releaseList.clear();
    _appList.clear();
    _testList.clear();
    appName = await AppCenter()
        .getApps(apiKey, owner)
        .then((response) => Applist.fromJson(jsonDecode(response.toString())));
    appCenterBranches(apiToken, owner);
  }

  void appCenterRelease(dynamic app, String apiKey, String owner) async {
    releaseCheck = await AppCenter()
        .getReleases(app.appName, apiKey, owner)
        .then((response) =>
            Releaselist.fromJson(jsonDecode(response.toString())));
    if (releaseCheck.releaseMap["releaseID"] != 0) {
      _releaseList.add(
        ReleaseList(
            appName: app.appName,
            appOs: app.os,
            releaseID: releaseCheck.releaseMap["releaseID"],
            uploadDate: releaseCheck.releaseMap["uploadDate"],
            uploadVersion: releaseCheck.releaseMap["uploadVersion"]),
      );
    }
    notifyListeners();
  }

  void appCenterTesting(dynamic app, String apiKey, String owner) async {
    testCheck = await AppCenter()
        .getTests(app.appName, apiKey, owner)
        .then((response) => TestMap.fromJson(jsonDecode(response.toString())));
    if (testCheck.testMap["testDate"] != "1999-04-08T09:32:24.744Z") {
      _testList.add(
        TestList(
            appVersion: testCheck.testMap['appVersion'],
            testDate: testCheck.testMap['testDate'],
            appOs: testCheck.testMap['appOs'],
            appName: app.appName,
            totalTests: testCheck.testMap['totalTests'],
            passTests: testCheck.testMap['passTests'],
            failedTests: testCheck.testMap['failedTests'],
            state: testCheck.testMap['state'],
            runStatus: testCheck.testMap['runStatus']),
      );
    }
    notifyListeners();
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
    latesRelease();
    sortList();
    buildAppCount;
    isData();
    notifyListeners();
  }

  void appCenterBranches(String apiKey, String owner) {
    for (var app in appName.appMap) {
      appCenterRelease(app, apiKey, owner);
      appCenterTesting(app, apiKey, owner);
      appCenterParseBranches(apiKey, app, owner);
    }
  }

  void latesRelease() {
    dynamic max;
    if (_releaseLatestList.isEmpty) {
      _releaseLatestList.add(
        ReleaseList(
            uploadVersion: "default",
            releaseID: 0,
            uploadDate: "1888-01-17T15:02:40.6543762Z",
            appName: "default",
            appOs: "default"),
      );
      max = _releaseLatestList[0];
    } else {
      max = _releaseLatestList[0];
    }
    _releaseList.forEach((e) {
      DateTime eDate = DateTime.parse(e.uploadDate).toUtc();
      DateTime maxDate = DateTime.parse(max.uploadDate).toUtc();
      if (eDate.toUtc().isAfter(maxDate.toUtc()) == true) {
        max = e;
        _releaseLatestList.isEmpty ? null : _releaseLatestList.clear();
        _releaseLatestList.add(
          ReleaseList(
              uploadVersion: max.uploadVersion,
              releaseID: max.releaseID,
              uploadDate: max.uploadDate,
              appName: max.appName,
              appOs: max.appOs),
        );
      }
    });
    notifyListeners();
  }

  void latesTest() {
    dynamic max;
    if (_testLatestList.isEmpty) {
      _testLatestList.add(
        TestList(
            appVersion: "Android",
            testDate: "1888-01-17T15:02:40.6543762Z",
            appOs: "default",
            appName: "default",
            totalTests: 0,
            passTests: 0,
            failedTests: 0,
            state: "default",
            runStatus: "default"),
      );
      max = _testLatestList[0];
    } else {
      max = _testLatestList[0];
    }
    _testList.forEach((e) {
      DateTime eDate = DateTime.parse(e.testDate).toUtc();
      DateTime maxDate = DateTime.parse(max.testDate).toUtc();
      if (eDate.toUtc().isAfter(maxDate.toUtc()) == true) {
        max = e;
        _testLatestList.isEmpty ? null : _testLatestList.clear();
        _testLatestList.add(
          TestList(
              appVersion: max.appVersion,
              testDate: max.testDate,
              appOs: max.appOs,
              appName: max.appName,
              totalTests: max.totalTests,
              passTests: max.passTests,
              failedTests: max.failedTests,
              state: max.state,
              runStatus: max.runStatus),
        );
      }
    });
    notifyListeners();
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
    if (_appList.length != buildAppCount) {
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
