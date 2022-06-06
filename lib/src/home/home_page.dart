import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/user_api.dart';
import 'package:chat_bot_creator/src/chatbot/chatbot_page.dart';
import 'package:chat_bot_creator/src/home/home_page_controller.dart';
import 'package:chat_bot_creator/src/home/widgets/new_chatbot_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "/home_page";

  @override
  Widget build(BuildContext context) {
    final HomePageController _controller = Get.put(HomePageController());
    final UserAPI _userAPI = Get.find<API>().user;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //TODO RELOAD TA TROLL N PEGA O NOME E RECLAMA Q N TEM HOMEPAGE
          title: Text("Chat Creator/ Bem Vindo ${_userAPI.name ?? ""}"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: _controller.chats.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _controller.chats.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Get.toNamed(
                          "/chat_page",
                          arguments:
                              ChatbotPageArguments(_controller.chats[index].id),
                        )!
                            .then(
                          (value) => _controller.reloadChats(),
                        ),
                        leading: const Icon(Icons.chat),
                        title: Text(_controller.chats[index].name),
                        subtitle: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                "Initial State: ${_controller.chats[index].initialState}"),
                            Text(
                                "Share Link: ${_controller.chats[index].shareLink}")
                          ],
                        ),
                      );
                    },
                  ),
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
