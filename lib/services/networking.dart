import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url, this.apiKey);
  final String url;
  final String apiKey;
  Future getData(String apiKey) async {
    http.Response response =
        await http.get(Uri.parse(url), headers: {"X-API-Token": apiKey, 'content-type': 'application/json'});
    if (response.statusCode == 200 && response.body != "[]") {
      String data = response.body;
      return data;
    } else if (response.statusCode == 200 && response.body == "[]") {
      print('empty reponse');
    } else {
      print(response.statusCode);
    }
  }
}
