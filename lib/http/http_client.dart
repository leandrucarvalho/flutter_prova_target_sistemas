import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future post({required String path, Map<String, dynamic>? body});
}

class HttpClient implements IHttpClient {
  final url = "https://aluminum-api-login.glitch.me";
  final client = http.Client();

  @override
  Future post({required String path, Map<String, dynamic>? body}) async {
    final response = await client.post(
      Uri.parse(url + path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return response;
  }
}
