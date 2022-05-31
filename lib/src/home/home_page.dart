import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:chat_bot_creator/api/user_api.dart';
import 'package:chat_bot_creator/src/chatbot/chatbot_page.dart';
import 'package:chat_bot_creator/src/home/widgets/new_chatbot_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "/home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserAPI _userAPI = Get.find<API>().user;
  final ChatBotAPI _chatbotAPI = Get.find<API>().chatbot;
  List<ChatBotModel> chats = [];

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) {
      _chatbotAPI.getAll().then((value) {
        if (mounted) {
          setState(() {
            chats = value;
          });
        }
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //TODO RELOAD TA TROLL N PEGA O NOME E RECLAMA Q N TEM HOMEPAGE
          title: Text("Chat Creator/ Bem Vindo ${_userAPI.name ?? ""}"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: chats.isEmpty
              ? Container()
              : ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => Get.toNamed(
                        "/chat_page",
                        arguments: ChatbotPageArguments(chats[index].id),
                      ),
                      leading: const Icon(Icons.chat),
                      title: Text(chats[index].name),
                      subtitle: Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Initial State: ${chats[index].initialState}"),
                          Text("Share Link: ${chats[index].shareLink}")
                        ],
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[100],
          onPressed: () => _showNewChatbotDialog(context),
          child: const Icon(Icons.add),
        ));
  }

  _showNewChatbotDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const NewChatbotWidget(),
    );
  }
}
