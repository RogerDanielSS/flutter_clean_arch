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

    var response = Response('', 500);

    switch(method){
      case 'post':
        response = await client.post(Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
        body: jsonBody);
      case 'get':
      case 'delete':
      case 'put':
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      case 500:
        throw HttpError.serverError;
      default:
        throw HttpError.serverError;
    }
  }
}
