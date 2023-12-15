import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client {
  // @override
  // Future<Response> post(Uri url, {Object? body, Encoding? encoding, Map<String, String>? headers}) async {
  //   return super.noSuchMethod(
  //     Invocation.method(
  //       #post,
  //       [url],
  //       {
  //         #body: body,
  //         #encoding: encoding,
  //         #headers: headers,
  //       },
  //     ),
  //     returnValue: Future.value(Response('', 200)), // Mock a successful response
  //   );
  // }
}


class HttpAdapter {
  Client client;

  HttpAdapter(this.client);

  Future<void> request({
    required String url, 
    required String method
  }) async {
    await client.post(Uri.parse(url));
  }
}


void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpsUrl();

      await sut.request(url: url, method: 'post');  

      verify(client.post(Uri.parse(url)));
    });
  });
}
