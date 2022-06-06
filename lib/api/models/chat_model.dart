import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:chat_bot_creator/api/models/states_models.dart';

class ChatBotModel {
  final int id;
  String name;
  final String shareLink;
  String initialState;
  List<StateBaseModel> states;
  final DioError? error;

  ChatBotModel({
    required this.id,
    required this.name,
    required this.shareLink,
    required this.initialState,
    this.states = const [],
    this.error,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'share_link': shareLink,
      'initial_state': initialState,
      'states': states.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatBotModel.fromMap(Map<String, dynamic> map) {
    return ChatBotModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      shareLink: map['share_link'] ?? '',
      initialState: map['initial_state'] ?? '',
      states: List<StateBaseModel>.from(map['states']?.map((x) => StateBaseModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatBotModel.fromJson(String source) => ChatBotModel.fromMap(json.decode(source));
}
