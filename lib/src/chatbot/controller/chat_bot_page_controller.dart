import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:chat_bot_creator/src/get_it_locator.dart';
import 'package:flutter/cupertino.dart';

class ChatBotPageController extends ChangeNotifier {
  ChatBotAPI _chatbotAPI = locator.get<API>().chatbot;

  ChatBotModel? _chatBotModel;

  ChatBotModel? get chatBotModel => _chatBotModel;

  Future<ChatBotModel> init(int id) async {
    _chatBotModel = await _chatbotAPI.getById(id);
    return _chatBotModel!;
  }
}
