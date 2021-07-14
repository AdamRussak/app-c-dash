import 'package:app_center_monitoring/services/networking.dart';
import 'package:app_center_monitoring/utilities/const.dart';

class AppCenter {
  NetworkHelper networkhelper;
  Future<dynamic> getApps(String apiKey) async {
    networkhelper = NetworkHelper('$KappCenterUrl/$KapiVersion/apps', apiKey);
    var weatherData = await networkhelper.getData(apiKey);
    return weatherData;
  }

  Future<dynamic> getBranches(
      String appName, String apiKey, String owner) async {
    networkhelper = NetworkHelper(
        '$KappCenterUrl/$KapiVersion/apps/$owner/$appName/branches', apiKey);
    var weatherData = await networkhelper.getData(apiKey);
    return weatherData;
  }

  Future<dynamic> getOwners(String apiKey) async {
    networkhelper = NetworkHelper('$KappCenterUrl/$KapiVersion/orgs', apiKey);
    var weatherData = await networkhelper.getData(apiKey);
    return weatherData;
  }

  Future<dynamic> getReleases(
      String appName, String apiKey, String owner) async {
    networkhelper = NetworkHelper(
        '$KappCenterUrl/$KapiVersion/apps/$owner/$appName/releases?published_only=false',
        apiKey);
    var weatherData = await networkhelper.getData(apiKey);
    return weatherData;
  }

  Future<dynamic> getTests(String appName, String apiKey, String owner) async {
    networkhelper = NetworkHelper(
        '$KappCenterUrl/$KapiVersion/apps/$owner/$appName/test_runs', apiKey);
    var weatherData = await networkhelper.getData(apiKey);
    return weatherData;
  }
}
