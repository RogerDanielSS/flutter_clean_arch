
import 'package:flutter_clean_arch/domain/entities/account_entity.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/use_cases/authentication.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient,  required this.url});

  Future<AccountEntity> auth(AuthenticationParams params ) async {
    try {
      final json = await httpClient.request(url: url, method: 'post', body:  
      RemoteAuthenticationParams.fromDomain(params).toJson());

      return AccountEntity.fromJson(json);
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
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