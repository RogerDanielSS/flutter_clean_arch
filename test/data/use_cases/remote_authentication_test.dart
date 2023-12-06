import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import 'package:flutter_clean_arch/domain/helpers/helpers.dart';
import 'package:flutter_clean_arch/domain/use_cases/use_cases.dart';

import 'package:flutter_clean_arch/data/use_cases/use_cases.dart';
import 'package:flutter_clean_arch/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {
  @override
  Future<void> request({required String? url, required String? method, Map? body}) async {
    return super.noSuchMethod(
      Invocation.method(#request, [url, method, body]),
      returnValue: Future.value(),
    );
  }
}

void main() {
  // arrange
  HttpClientSpy httpClient = HttpClientSpy();
  String url = faker.internet.httpUrl();
  RemoteAuthentication sut = RemoteAuthentication(httpClient: httpClient, url: url); //system_under_test
  
  setUp(() {
  });

  test('Should call HttpClient with correct values', () async {
    //design pattern: triple A (arrange, act, asert)
    //arrange
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());

    // act
    sut.auth(params);

    // assert
    verify(httpClient.request(url: url, method: 'post', body: RemoteAuthenticationParams.fromDomain(params).toJson()));
  });

  test('Should return UnexpectedError if HttpClient returns error 400', () async {

    //arrange
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());

    when(httpClient.request(url: url, method: 'post', body:  RemoteAuthenticationParams.fromDomain(params).toJson()))
    .thenThrow(HttpError.badRequest);

    // act
    final future = sut.auth(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
