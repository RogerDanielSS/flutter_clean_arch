
import '../../domain/use_cases/authentication.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient,  required this.url});

  Future<void> auth(AuthenticationParams params ) async {
    httpClient.request(url: url, method: 'post', body:  
    RemoteAuthenticationParams.fromDomain(params).toJson());
  }
}
class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) => 
    RemoteAuthenticationParams(email: params.email, password: params.password);

  Map toJson () => {'email': email, 'password': password};
}