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
