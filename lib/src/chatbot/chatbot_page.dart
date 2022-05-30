import 'package:chat_bot_creator/src/chatbot/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/chat_bot_page_controller.dart';

class ChatbotPageArguments {
  final int id;

  ChatbotPageArguments(this.id);
}

class ChatbotPage extends StatefulWidget {
  final ChatbotPageArguments arguments;
  const ChatbotPage(this.arguments, {Key? key}) : super(key: key);
  static const routeName = "/chat_page";

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final ChatBotPageController _controller = Get.put(ChatBotPageController());

  @override
  Widget build(BuildContext context) {
    if (_controller.chatBotModel == null) {
      _controller.init(widget.arguments.id).then(
        (value) {
          setState(() {});
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(_controller.chatBotModel?.name ?? ""),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
