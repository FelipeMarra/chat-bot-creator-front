import 'dart:convert';

import 'package:dio/dio.dart';

class UserModel {
  final String name;
  final String email;
  final String accessToken;
  final int id;
  final DioError? error;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.accessToken,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'accessToken': accessToken,
      'id': id,
    };
  }

  bool get hasError => error != null;

  String get getError {
    if (error?.error == "Http status error [403]") {
      return "User: Email already registred";
    }
    if (error?.error == "Http status error [404]") {
      return "User: User not found";
    }
    return "${error?.message} ${error?.response?.data["details"] ?? ""}";
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      accessToken: map['access_token'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
