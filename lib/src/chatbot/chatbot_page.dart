import 'package:chat_bot_creator/src/chatbot/widgets/title_widget.dart';
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
  final ChatBotPageController _controller = Get.put(ChatBotPageController());

  @override
  void initState() {
    _controller.init(widget.arguments.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
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
        }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
