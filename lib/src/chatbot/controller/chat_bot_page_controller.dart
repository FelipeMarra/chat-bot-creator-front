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

  Future<void> createState(StateBaseModel newState) async {
    newState = await _statesAPI.createStateBase(newState);
    _chatBotModel.update((oldChat) {
      oldChat!.states = [...oldChat.states, newState];
    });
  }

  //TODO update não remove nem adiciona, apenas modifica os já existentes
  Future<void> updateState(StateBaseModel stateToUpdate) async {
    await _statesAPI.update(stateToUpdate);

    //UI update
    List<StateBaseModel> newStates = _chatBotModel.value.states;
    int index = _chatBotModel.value.states.indexWhere(
      (element) => element.id == stateToUpdate.id,
    );
    newStates[index] = stateToUpdate;
    _chatBotModel.update((oldChat) {
      oldChat!.states = newStates;
    });
  }

  //TODO problema no back
  Future<void> deleteState(StateBaseModel state) async {
    await _statesAPI.delete(state.id);
    _chatBotModel.value.states.removeWhere((element) => element.id == state.id);
  }

  Future<void> init(int id) async {
    ChatBotModel newModel = await _chatbotAPI.getById(id);
    _chatBotModel(newModel);
    isReady.value = true;
  }
}
