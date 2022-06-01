import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/src/chatbot/widgets/title_widget.dart';
import 'package:chat_bot_creator/src/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/chat_bot_page_controller.dart';

class ChatbotPageArguments {
  final int id;

  ChatbotPageArguments(this.id);
}

class ChatBotPage extends StatefulWidget {
  final ChatbotPageArguments arguments;
  const ChatBotPage(this.arguments, {Key? key}) : super(key: key);
  static const routeName = "/chat_page";

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final ChatBotAPI _chatbotAPI = Get.find<API>().chatbot;
  final ChatBotPageController _controller = Get.put(ChatBotPageController());
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    _controller.init(widget.arguments.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleWidget(),
        actions: [
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () async {
              int res = await _chatbotAPI.delete(widget.arguments.id);

              if (res != 200) {
                showErrorDialog(
                  context,
                  "Error Trying To Delete ChatBot ${widget.arguments.id}:",
                  "Status: $res",
                );
                return;
              }

              Get.back();
            },
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () async {
              int res =
                  await _chatbotAPI.update(_controller.chatBotModel.value);

              if (res != 200) {
                showErrorDialog(
                  context,
                  "Error Trying To Update ChatBot ${widget.arguments.id}:",
                  "Status: $res",
                );
                return;
              }

              Get.snackbar(
                "You ChatBot was updated",
                "",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            icon: const Icon(Icons.save),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      //TODO initial state: tem q pegar todos os estados e mostrar p poder escolher qual vai ser o inicial
    );
  }

  Obx _titleWidget() {
    return Obx(() {
      nameController.text = _controller.chatBotModel.value.name;
      return TitleWidget(
        textController: nameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required Field";
          }
          return null;
        },
        onChange: (newName) => _controller.setChatBotName(newName),
      );
    });
  }
}
