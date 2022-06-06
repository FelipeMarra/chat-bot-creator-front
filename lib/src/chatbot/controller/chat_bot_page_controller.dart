import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:get/get.dart';

class ChatBotPageController extends GetxController {
  final ChatBotAPI _chatbotAPI = Get.find<API>().chatbot;

  final Rx<ChatBotModel> _chatBotModel = ChatBotModel(
    id: -1,
    name: "",
    shareLink: "",
    initialState: "",
    states: [],
  ).obs;

  RxBool isReady = false.obs;

  Rx<ChatBotModel> get chatBotModel => _chatBotModel;

  List<StateBaseModel> get states => _chatBotModel.value.states;

  void setChatBotName(String newName) {
    _chatBotModel.value.name = newName;
  }

  void addState(StateBaseModel newState) {
    print("ADD STATE");
    _chatBotModel.value.states.add(newState);
    _chatBotModel(_chatBotModel.value);
  }

  Future<void> init(int id) async {
    ChatBotModel newModel = await _chatbotAPI.getById(id);
    _chatBotModel(newModel);
    isReady.value = true;
  }
}
