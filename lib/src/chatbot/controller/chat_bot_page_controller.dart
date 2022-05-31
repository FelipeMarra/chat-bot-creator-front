import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:get/get.dart';

class ChatBotPageController extends GetxController {
  final ChatBotAPI _chatbotAPI = Get.find<API>().chatbot;

  final Rx<ChatBotModel> _chatBotModel = ChatBotModel(
    id: -1,
    name: "",
    shareLink: "",
    initialState: "",
  ).obs;

  Rx<ChatBotModel> get chatBotModel => _chatBotModel;

  void setChatBotName(String newName) {
    _chatBotModel.value.name = newName;
    print(_chatBotModel.value.name);
    // _chatBotModel.update(
    //   (model) {
    //     model!.name = newName;
    //   },
    // );
  }

  Future<Rx<ChatBotModel>> init(int id) async {
    ChatBotModel newModel = await _chatbotAPI.getById(id);
    _chatBotModel(newModel);
    print("Pegamo o ${_chatBotModel.value.name}");
    return _chatBotModel;
  }
}
