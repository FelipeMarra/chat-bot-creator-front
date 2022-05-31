import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  HomePageController() {
    reloadChats();
  }

  final ChatBotAPI _chatbotAPI = Get.find<API>().chatbot;

  RxList<ChatBotModel> chats = <ChatBotModel>[].obs;

  reloadChats() async {
    if (chats.isNotEmpty) {
      chats.clear();
    }
    _chatbotAPI.getAll().then((newList) {
      chats.addAll(newList);
    });
  }

  updateChats(List<ChatBotModel> newList) {
    chats.addAll(newList);
  }
}
