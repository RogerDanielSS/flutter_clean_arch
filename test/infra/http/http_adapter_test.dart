import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_clean_arch/data/http/http.dart';

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

    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
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

    When mockRequest = when(() => client.post(Uri.parse(url), headers: headers));
    
    void mockResponse(int statusCode, {String body = '{"any_ke y": "any_value"}'}) {
      mockRequest
          .thenAnswer((_) async => Response(body, statusCode));
    }


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
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    
    test('Should return null if post returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
  });
}
