import 'package:chat_bot_creator/src/get_it_locator.dart';
import 'package:flutter/material.dart';
import 'controller/chat_bot_page_controller.dart';

class ChatbotPageArguments {
  final int id;

  ChatbotPageArguments(this.id);
}

class ChatbotPage extends StatefulWidget {
  final ChatbotPageArguments arguments;
  const ChatbotPage(this.arguments, {Key? key}) : super(key: key);
  static const routeName = "chat_page";

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  @override
  Widget build(BuildContext context) {
    ChatBotPageController _controller = locator.get<ChatBotPageController>();

    if (_controller.chatBotModel == null) {
      _controller.init(widget.arguments.id).then(
        (value) {
          setState(() {});
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.chatBotModel?.name ?? ""),
      ),
    );
  }
}
