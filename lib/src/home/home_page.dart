import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:chat_bot_creator/api/user_api.dart';
import 'package:chat_bot_creator/src/chatbot/chatbot_page.dart';
import 'package:chat_bot_creator/src/get_it_locator.dart';
import 'package:chat_bot_creator/src/home/widgets/new_chatbot_widget.dart';
import 'package:chat_bot_creator/src/widgets/error_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatBotModel> chats = [];

  @override
  Widget build(BuildContext context) {
    UserAPI _userAPI = locator.get<API>().user;
    ChatBotAPI _chatbotAPI = locator.get<API>().chatbot;

    if (chats.isEmpty) {
      _chatbotAPI.getAll().then((value) {
        setState(() {
          chats = value;
        });
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
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          //TODO MOVER DAQUI PARA PAGINA DE CHATBOT
                          IconButton(
                            onPressed: () async {
                              String res =
                                  await _chatbotAPI.delete(chats[index].id);

                              if (res != "200 OK") {
                                showErrorDialog(
                                  context,
                                  "Error Trying To Delete ChatBot ${chats[index].name}:",
                                  res,
                                );
                                return;
                              }

                              setState(() {
                                chats.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
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
    ).then((value) {
      Navigator.of(context).popAndPushNamed(
        ChatbotPage.routeName,
        arguments: ChatbotPageArguments(chats.length + 1),
      );
    });
  }
}
