import 'dart:convert';

import 'package:dio/dio.dart';

class RegistrationModel {
  final String? name;
  final String? email;
  final String? password;
  final DioError? error;

  RegistrationModel({
    this.name,
    this.email,
    this.password,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  String get getError {
    if (error?.error == "Http status error [403]") {
      return "A user with this email already exists";
    }
    return "${error?.message} ${error?.response?.data["details"] ?? ""}";
  }

  factory RegistrationModel.fromMap(Map<String, dynamic> map) {
    return RegistrationModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationModel.fromJson(String source) =>
      RegistrationModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'RegistrationModel(name: $name, email: $email, password: $password)';
}
