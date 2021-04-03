import 'dart:io';

//create the convertion from json to map to get the app lists
class AppMap {
  String owner;
  String appName;
  String os;
  String platform;
  AppMap(this.appName, this.owner, this.os, this.platform) {
    this.appName = appName;
    this.owner = owner;
  }
  AppMap.fromJson(Map json)
      : appName = json['name'],
        owner = json['owner']['name'],
        platform = json['platform'],
        os = json['os'];
}

//create the list of apps
class Applist {
  List<AppMap> appMap;
  Applist([this.appMap]);
  factory Applist.fromJson(dynamic json) {
    if (json != null) {
      var appObjJson = json as List;
      List<AppMap> _appList =
          appObjJson.map((json) => AppMap.fromJson(json)).toList();
      return Applist(_appList);
    } else {
      exit(100);
    }
  }
}

//create conversion form json to brnach info
class AppStatusMap {
  String branchName;
  int buildNumber;
  String buildStatus;
  String BuildResult;
  String finishTime;
  bool isConfigured;

  AppStatusMap(this.BuildResult, this.branchName, this.buildNumber,
      this.buildStatus, this.finishTime, this.isConfigured) {
    branchName = this.branchName;
    buildNumber = this.buildNumber;
    buildStatus = this.buildStatus;
    BuildResult = this.BuildResult;
    finishTime = this.finishTime;
    isConfigured = this.isConfigured;
  }

  AppStatusMap.fromJson(Map json)
      : branchName = json['branch']['name'],
        buildNumber = json['lastBuild']['id'],
        buildStatus = json['lastBuild']['status'],
        BuildResult = json['lastBuild']['result'],
        finishTime = json['lastBuild']['finishTime'],
        isConfigured = json['configured'];
}

//create the list of apps
class Branchlist {
  Map appMap;
  Branchlist([this.appMap]);
  factory Branchlist.fromJson(dynamic json) {
    var isConfig;
    if (json != null) {
      var appObjJson = json as List;
      dynamic max = appObjJson.first['lastBuild'] == null
          ? {
              'lastBuild': {'id': 0},
              'configured': false
            }
          : appObjJson.first;
      appObjJson.forEach((e) {
        if (e['configured'] == true) {
          isConfig = true;
          if (e.containsKey('lastBuild')) {
            if (e['lastBuild']['id'] > max['lastBuild']['id'] ||
                !max.containsKey('lastBuild')) {
              max = e;
            }
            ;
          }
        } else if (e['configured'] == false && max['configured'] == false) {
          isConfig = false;
        } else if (e['message'] == "App has not been configured for build") {
          isConfig = false;
        }
      });
      var branchMapping;
      if (max['lastBuild']['status'] == 'inProgress') {
        branchMapping = {
          'branchName': max['branch']['name'],
          'buildNumber': max['lastBuild']['id'],
          'buildStatus': max['lastBuild']['status'],
          'buildResult': max['lastBuild']['status'],
          'finishTime': max['lastBuild']['status'],
          'isConfigured': max['configured']
        };
      } else if (isConfig == false) {
        branchMapping = {
          'branchName': "NotConfigured",
          'buildNumber': 0,
          'buildStatus': "NotConfigured",
          'buildResult': "NotConfigured",
          'finishTime': "NotConfigured",
          'isConfigured': "NotConfigured"
        };
      } else {
        branchMapping = {
          'branchName': max['branch']['name'],
          'buildNumber': max['lastBuild']['id'],
          'buildStatus': max['lastBuild']['status'],
          'buildResult': max['lastBuild']['result'],
          'finishTime': max['lastBuild']['finishTime'],
          'isConfigured': max['configured']
        };
      }

      return Branchlist(branchMapping);
    } else {
      exit(100);
    }
  }
}

class OwnerMap {
  String ownerName;

  OwnerMap(this.ownerName) {
    this.ownerName = ownerName;
  }
  OwnerMap.fromJson(Map json) : ownerName = json['name'];
}

//create the list of apps
class Ownerlist {
  List<OwnerMap> ownerMap;
  Ownerlist([this.ownerMap]);
  factory Ownerlist.fromJson(dynamic json) {
    if (json != null) {
      var appObjJson = json as List;
      List<OwnerMap> _ownerList =
          appObjJson.map((json) => OwnerMap.fromJson(json)).toList();
      return Ownerlist(_ownerList);
    } else {
      exit(100);
    }
  }
}
