
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication{
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient,  required this.url});

  Future<void> auth() async {
    httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({required String url,  required String method});
}

class HttpClientSpy extends Mock implements HttpClient {
  @override
  Future<void> request({required String url, required String method}) async {
    return super.noSuchMethod(
      Invocation.method(#request, [url, method]),
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

    // act
    sut.auth();

    // assert
    verify(httpClient.request(url: url, method: 'post'));
  });
}