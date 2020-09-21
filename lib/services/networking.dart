import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String _url;

  NetworkHelper(this._url);

  Future getData() async {
    http.Response response = await http.get(_url);
    print(_url);

    if (response.statusCode == 200) {
      String responseData = response.body;
      return jsonDecode(responseData);
    } else {
      return response.statusCode;
    }
  }
}
