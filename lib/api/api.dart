import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/services/login_service.dart';
import 'package:chat_bot_creator/api/user_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class API extends ChangeNotifier {
  //static const baseUrl = "https://chat-bot-creator-back.herokuapp.com";
  static const baseUrl = "http://127.0.0.1:8000";
  late Dio _dio;
  late LoginService _loginService;
  late UserAPI user;
  late ChatBotAPI chatbot;

  bool initiated = false;

  API() : super() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
  }

  Future init() async {
    _loginService = LoginService(_dio, baseUrl);
    await _loginService.init();

    user = UserAPI(_dio, _loginService);
    await user.init();

    chatbot = ChatBotAPI(_dio);

    initiated = true;
    notifyListeners();
  }
}
