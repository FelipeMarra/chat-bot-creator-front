import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/src/chatbot/controller/chat_bot_page_controller.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupGetIt() {
  locator.registerSingleton<API>(API());
  locator.registerLazySingleton<ChatBotPageController>(() => ChatBotPageController());
}
