import 'dart:convert';

import 'package:dio/dio.dart';

class ChatBotModel {
  final int id;
  final String name;
  final String shareLink;
  final String initialState;
  final DioError? error;

  ChatBotModel({
    required this.id,
    required this.name,
    required this.shareLink,
    required this.initialState,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shareLink': shareLink,
      'initialState': initialState,
    };
  }

  bool get hasError => error != null;

  String get getError {
    // if (error?.error == "Http status error [403]") {
    //   return "User: Email already registred";
    // }
    // if (error?.error == "Http status error [404]") {
    //   return "User: User not found";
    // }
    return "${error?.message} ${error?.response?.data["details"] ?? ""}";
  }

  factory ChatBotModel.fromMap(Map<String, dynamic> map) {
    return ChatBotModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      shareLink: map['share_link'] ?? '',
      initialState: map['initial_state'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatBotModel.fromJson(String source) =>
      ChatBotModel.fromMap(json.decode(source));
}
