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

//create the list of Releases
class Releaselist {
  Map releaseMap;
  Releaselist([this.releaseMap]);
  factory Releaselist.fromJson(dynamic json) {
    var _releaseList;
    if (json != null) {
      var appObjJson = json as List;
      dynamic max = appObjJson.first['uploaded_at'] == null
          ? {
              'lastBuild': {'id': 0},
              'uploaded_at': "1999-04-08T09:32:24.744Z"
            }
          : appObjJson.first;
      appObjJson.forEach((e) {
        if (e['enabled'] == true) {
          if (e.containsKey('uploaded_at')) {
            DateTime eDate = DateTime.parse(e['uploaded_at']).toUtc();
            DateTime maxDate = DateTime.parse(max['uploaded_at']).toUtc();
            if (eDate.toUtc().isAfter(maxDate.toUtc()) == true) {
              max = e;
            }
            ;
          }
        }
      });
      _releaseList = {
        'releaseID': max['id'],
        'uploadVersion': max['short_version'],
        'uploadDate': max['uploaded_at']
      };
    } else {
      _releaseList = {
        'releaseID': 0,
        'uploadVersion': "1.0.0",
        'uploadDate': "1999-04-08T09:32:24.744Z"
      };
    }
    return Releaselist(_releaseList);
  }
}

//TODO: fix the TestList class
// crete list for testing from json
class TestMap {
  Map testMap;
  TestMap([this.testMap]);
  factory TestMap.fromJson(dynamic json) {
    var _testList;
    if (json != null) {
      var appObjJson = json as List;
      dynamic max = appObjJson.first['date'] == null
          ? {'testDate': "1999-04-08T09:32:24.744Z"}
          : appObjJson.first;
      appObjJson.forEach((e) {
        if (e.containsKey('date')) {
          DateTime eDate = DateTime.parse(e['date']).toUtc();
          DateTime maxDate = DateTime.parse(max['date']).toUtc();
          if (eDate.toUtc().isAfter(maxDate.toUtc()) == true) {
            max = e;
          }
          ;
        }
      });
      _testList = {
        'appVersion': max['appVersion'],
        'testDate': max['date'],
        'appOs': max['platform'],
        'totalTests': max['stats']['total'],
        'passTests': max['stats']['passed'],
        'failedTests': max['stats']['failed'],
        'state': max['state'],
        'runStatus': max['runStatus'],
      };
    }
    return TestMap(_testList);
  }
}
