import 'dart:convert';

class UserModel {
  String username;
  String password;

  UserModel({
    required this.username,
    required this.password,
  });

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    if (map['username'] is String && map['password'] is String) {
      return UserModel(
        username: map['username'] as String,
        password: map['password'] as String,
      );
    } else {
      throw const FormatException('Dados inválidos na resposta da API');
    }
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<dynamic, dynamic>);
}
