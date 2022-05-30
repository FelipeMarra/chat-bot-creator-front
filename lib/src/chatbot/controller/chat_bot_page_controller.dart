import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatBotPageController extends ChangeNotifier {
  final ChatBotAPI _chatbotAPI = Get.find<API>().chatbot;

  ChatBotModel? _chatBotModel;

  ChatBotModel? get chatBotModel => _chatBotModel;

  Future<ChatBotModel> init(int id) async {
    _chatBotModel = await _chatbotAPI.getById(id);
    print("Pegamo o ${_chatBotModel!.name}");
    return _chatBotModel!;
  }
}
