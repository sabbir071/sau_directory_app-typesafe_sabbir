
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:sau_directory/config/constant.dart';


class PrivateAPI {

  Future<http.Response> get(String path, {Map<String, String?>? queryParams}) async {
    var uri = _makeUri(path, queryParams: queryParams);

    print(uri);
    final requester = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return requester;
  }

  Future<http.Response> post(String path,
      {Object? body, Map<String, String?>? queryParams}) async {

    final requester = http.post(
      _makeUri(path, queryParams: queryParams),
      body: convert.jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return requester;
  }

  Uri _makeUri(String path, {Map<String, String?>? queryParams}) {
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    return Uri.http(apiURL, visibility+apiBase + path, queryParams);
  }
}