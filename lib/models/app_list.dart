class AppList {
  final String branchName;
  final int buildNumber;
  final String buildStatus;
  final String buildResult;
  final String finishTime;
  final String appName;
  final String appOs;
  final String platform;
  final String owner;
  AppList(
      {this.buildResult,
      this.branchName,
      this.buildNumber,
      this.buildStatus,
      this.finishTime,
      this.appName,
      this.platform,
      this.owner,
      this.appOs});
}

class ReleaseList {
  final int releaseID;
  final String uploadVersion;
  final String appName;
  final String appOs;
  final String uploadDate;
  ReleaseList(
      {this.releaseID,
      this.uploadVersion,
      this.appName,
      this.uploadDate,
      this.appOs});
}

class TestList {
  final String appVersion;
  final int totalTests;
  final int passTests;
  final int failedTests;
  final String state;
  final String runStatus;
  final String appName;
  final String testDate;
  final String appOs;

  TestList(
      {this.appVersion,
      this.testDate,
      this.appOs,
      this.appName,
      this.totalTests,
      this.passTests,
      this.failedTests,
      this.state,
      this.runStatus});
}
