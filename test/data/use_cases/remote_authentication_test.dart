
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/domain/use_cases/use_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication{
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient,  required this.url});

  Future<void> auth(AuthenticationParams params ) async {
    httpClient.request(url: url, method: 'post', body: params.toJson());
  }
}

abstract class HttpClient {
  Future<void> request({required String url,  required String method, Map body});
}

class HttpClientSpy extends Mock implements HttpClient {
  @override
  Future<void> request({required String url, required String method, Map? body}) async {
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
    verify(httpClient.request(url: url, method: 'post', body: params.toJson()));
  });
}