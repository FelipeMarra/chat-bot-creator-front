import 'dart:convert';

import 'package:dio/dio.dart';

class StateBaseModel {
  int id;
  String name;
  int chatbotId;
  List<StateMessageModel> messages;
  List<StateTransitionModel> transitions;
  final DioError? error;

  StateBaseModel(
      {required this.id,
      required this.chatbotId,
      required this.name,
      required this.messages,
      required this.transitions,
      this.error});

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
      'chatbot_id': chatbotId,
      'messages': messages.map((x) => x.toMap()).toList(),
      'transitions': transitions.map((x) => x.toMap()).toList(),
    };
  }

  factory StateBaseModel.fromMap(Map<String, dynamic> map) {
    return StateBaseModel(
      id: map['id']?.toInt() ?? -1,
      name: map['name'] ?? '',
      chatbotId: map['chatbot_id']?.toInt() ?? -1,
      messages: List<StateMessageModel>.from(
          map['messages']?.map((x) => StateMessageModel.fromMap(x))),
      transitions: List<StateTransitionModel>.from(
          map['transitions']?.map((x) => StateTransitionModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory StateBaseModel.fromJson(String source) =>
      StateBaseModel.fromMap(json.decode(source));
}

class StateMessageModel {
  int id;
  int stateId;
  String message;
  String typeMessage;

  StateMessageModel({
    required this.id,
    required this.stateId,
    required this.message,
    required this.typeMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'state_id': stateId,
      'message': message,
      'type_message': typeMessage,
    };
  }

  factory StateMessageModel.fromMap(Map<String, dynamic> map) {
    return StateMessageModel(
      id: map['id']?.toInt() ?? -1,
      stateId: map['state_id']?.toInt() ?? -1,
      message: map['message'] ?? '',
      typeMessage: map['type_message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StateMessageModel.fromJson(String source) =>
      StateMessageModel.fromMap(json.decode(source));
}

class StateTransitionModel {
  int id;
  int stateId;
  int transitionTo;

  StateTransitionModel({
    required this.id,
    required this.stateId,
    required this.transitionTo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'state_id': stateId,
      'transition_to': transitionTo,
    };
  }

  factory StateTransitionModel.fromMap(Map<String, dynamic> map) {
    return StateTransitionModel(
      id: map['id']?.toInt() ?? -1,
      stateId: map['state_id']?.toInt() ?? -1,
      transitionTo: map['transition_to'] ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateTransitionModel.fromJson(String source) =>
      StateTransitionModel.fromMap(json.decode(source));
}
