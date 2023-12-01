
import '../../domain/use_cases/authentication.dart';

import '../http/http.dart';

class RemoteAuthentication{
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient,  required this.url});

  Future<void> auth(AuthenticationParams params ) async {
    httpClient.request(url: url, method: 'post', body: params.toJson());
  }
}
