import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_clean_arch/data/http/http.dart';

import 'package:flutter_clean_arch/infra/http/http.dart';

class ClientSpy extends Mock implements Client {
  ClientSpy() {
    mockPost(200);
  }

  When mockPostCall() => when(() => this
      .post(any(), body: any(named: 'body'), headers: any(named: 'headers')));

  void mockPost(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPostCall().thenAnswer((_) async => Response(body, statusCode));

  void mockPostError() => when(() => mockPostCall().thenThrow(Exception()));
}

void main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });

  group('post', () {
    const body = {'any_key': 'any_value'};
    const headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    test('Should call post with correct values', () async {
      await sut.request(url: url, method: 'post', body: body);

      verify(() => client.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body))).called(1);
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(() => client.post(Uri.parse(url), headers: headers)).called(1);
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no content', () async {
      client.mockPost(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return null if post returns 200 with no contenta', () async {
      client.mockPost(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return null if post returns 204', () async {
      client.mockPost(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return null if post returns 204 with data', () async {
      client.mockPost(204);

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return BadRequestError if post returns 400', () async {
      client.mockPost(400);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });
  });
}
