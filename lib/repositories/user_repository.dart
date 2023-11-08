import 'dart:convert';
import '../http/http_client.dart';

abstract class IUserRepository {
  Future<bool> authenticateUser(String username, String password);
}

class UserRepository implements IUserRepository {
  final IHttpClient client;

  UserRepository({required this.client});

  @override
  Future<bool> authenticateUser(String username, String password) async {
    final body = {
      "username": username,
      "password": password,
    };

    final response = await client.post(path: "/login", body: body);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['message'] == "Login bem-sucedido!") {
        return true;
      }
      return false;
    } else if (response.statusCode == 401) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['message'] == "Credenciais inválidas.") {
        return false;
      }
      return true;
    }
    return response;
  }
}
