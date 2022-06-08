import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:chat_bot_creator/api/states_api.dart';
import 'package:get/get.dart';

class ChatBotPageController extends GetxController {
  final ChatBotAPI _chatbotAPI = Get.find<API>().chatbot;
  final StatesAPI _statesAPI = Get.find<API>().statesAPI;

  final Rx<ChatBotModel> _chatBotModel = ChatBotModel(
    id: -1,
    name: "",
    shareLink: "",
    initialState: "",
    states: [],
  ).obs;

  RxBool isReady = false.obs;

  Rx<ChatBotModel> get chatBotModel => _chatBotModel;

  void setChatBotName(String newName) {
    _chatBotModel.value.name = newName;
  }

  void createState(StateBaseModel newState) async {
    newState = await _statesAPI.createStateBase(newState);
    _chatBotModel.update((oldChat) {
      oldChat!.states = [...oldChat.states, newState];
    });
  }

  void deleteState(StateBaseModel state) async {
    await _statesAPI.delete(state.id);
    _chatBotModel.value.states.removeWhere((element) => element.id == state.id);
  }

  Future<void> init(int id) async {
    ChatBotModel newModel = await _chatbotAPI.getById(id);
    _chatBotModel(newModel);
    isReady.value = true;
  }
}
