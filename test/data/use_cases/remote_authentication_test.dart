import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import 'package:flutter_clean_arch/domain/helpers/helpers.dart';
import 'package:flutter_clean_arch/domain/use_cases/use_cases.dart';

import 'package:flutter_clean_arch/data/use_cases/use_cases.dart';
import 'package:flutter_clean_arch/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {
  @override
  Future<Map> request({required String? url, required String? method, Map? body}) async {
    return super.noSuchMethod(
      Invocation.method(#request, [url, method, body]),
      returnValue: Future<Map>.value({}),
    );
  }
}

void main() {
  // arrange
  HttpClientSpy httpClient = HttpClientSpy();
  String url = faker.internet.httpUrl();
  RemoteAuthentication sut = RemoteAuthentication(httpClient: httpClient, url: url); //system_under_test
  final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
  
  setUp(() {
  });

  test('Should call HttpClient with correct values', () async {
    when(httpClient.request(url: url, method: 'post', body:  RemoteAuthenticationParams.fromDomain(params).toJson()))
    .thenAnswer((_) async => {'name': faker.person.name(), 'accessToken': faker.guid.guid()});

    // act
    sut.auth(params);

    // assert
    verify(httpClient.request(url: url, method: 'post', body: RemoteAuthenticationParams.fromDomain(params).toJson()));
  });

  test('Should return UnexpectedError if HttpClient returns error 400', () async {
    when(httpClient.request(url: url, method: 'post', body:  RemoteAuthenticationParams.fromDomain(params).toJson()))
    .thenThrow(HttpError.badRequest);

    // act
    final future = sut.auth(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return UnexpectedError if HttpClient returns error 404', () async {
    when(httpClient.request(url: url, method: 'post', body:  RemoteAuthenticationParams.fromDomain(params).toJson()))
    .thenThrow(HttpError.notFound);

    // act
    final future = sut.auth(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });
  
  test('Should return UnexpectedError if HttpClient returns error 500', () async {
    when(httpClient.request(url: url, method: 'post', body:  RemoteAuthenticationParams.fromDomain(params).toJson()))
    .thenThrow(HttpError.serverError);

    // act
    final future = sut.auth(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });
  
  test('Should return InvalidCredentialsError if HttpClient returns error 401', () async {
    when(httpClient.request(url: url, method: 'post', body:  RemoteAuthenticationParams.fromDomain(params).toJson()))
    .thenThrow(HttpError.unauthorized);

    // act
    final future = sut.auth(params);

    // assert
    expect(future, throwsA(DomainError.invalidCredentials));
  });
  
  test('Should return AccountEntity if HttpClient returns 200', () async {
    final accessToken =  faker.guid.guid();

    when(httpClient.request(url: url, method: 'post', body:  RemoteAuthenticationParams.fromDomain(params).toJson()))
    .thenAnswer((_) async => {'name': faker.person.name(), 'accessToken': accessToken});

    // act
    final account = await sut.auth(params);

    // assert
    expect(account.token, accessToken);
  });
  
  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    when(httpClient.request(url: url, method: 'post', body:  RemoteAuthenticationParams.fromDomain(params).toJson()))
    .thenAnswer((_) async => {'invalid_key': 'invalid_value'});

    // act
    final future = sut.auth(params);

    // assert
    expect(future, throwsA(DomainError.unexpected));
  });
}