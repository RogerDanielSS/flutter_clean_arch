
import 'dart:convert';
import '../../data/http/http.dart';

import 'package:http/http.dart';

class HttpAdapter implements HttpClient {
  Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request(
      {required String url, required String method, Map? body}) async {
    final jsonBody = body != null ? jsonEncode(body) : null;

    final response = await client.post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
        body: jsonBody);

    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 200) {
      return null;
    }
  }
}
