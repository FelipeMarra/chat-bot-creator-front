import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/user_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserAPI _userAPI = context.read<API>().user;

    //TODO Improve the uai we get user on api
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Chat Creator/ Bem Vindo ${_userAPI.name}"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Seus chats"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
