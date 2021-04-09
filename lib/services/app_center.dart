// get all projects (apps):
// curl -X GET "https://api.appcenter.ms/v0.1/orgs/Antelliq-Innovation-Center/apps" -H  "accept: application/json" -H  "X-API-Token: 1c9c9081d670a527c320d84d34416efb3c28c562"

// get all branches and last build:
// curl -X GET "https://api.appcenter.ms/v0.1/apps/Antelliq-Innovation-Center/senshub-mobile-ios/branches" -H  "accept: application/json" -H  "X-API-Token: 1c9c9081d670a527c320d84d34416efb3c28c562"
//get orgs
// curl -X GET "https://api.appcenter.ms/v0.1/orgs" -H  "accept: application/json" -H  "X-API-Token: 1c9c9081d670a527c320d84d34416efb3c28c562"
import 'package:app_center_monitoring/services/networking.dart';
import 'package:app_center_monitoring/utilities/const.dart';

class AppCenter {
  NetworkHelper networkhelper;
  Future<dynamic> getApps(String apiKey, String owner) async {
    networkhelper =
        NetworkHelper('$KappCenterUrl/$KapiVersion/orgs/$owner/apps', apiKey);
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
        '$KappCenterUrl/$KapiVersion/apps/$owner/$appName/test_series', apiKey);
    var weatherData = await networkhelper.getData(apiKey);
    return weatherData;
  }
}
