import 'package:dio/dio.dart';

class LoginModel {
  final String accessToken;
  final DioError? error;

  LoginModel({
    required this.accessToken,
    this.error,
  });

  bool get hasError => error != null;

  String get getError {
    if (error?.error == "Http status error [404]") {
      return "Login: User not found";
    }
    return "${error?.message} ${error?.response?.data["details"] ?? ""}";
  }
}
