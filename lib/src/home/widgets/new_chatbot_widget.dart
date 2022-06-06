import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/chat_bot_api.dart';
import 'package:chat_bot_creator/api/models/chat_model.dart';
import 'package:chat_bot_creator/src/chatbot/chatbot_page.dart';
import 'package:chat_bot_creator/src/home/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewChatbotWidget extends StatefulWidget {
  const NewChatbotWidget({Key? key}) : super(key: key);

  @override
  State<NewChatbotWidget> createState() => _NewChatbotWidgetState();
}

class _NewChatbotWidgetState extends State<NewChatbotWidget> {
  final HomePageController _controller = Get.find();
  final ChatBotAPI _chatbotAPI = Get.find<API>().chatbot;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  label: Text("Chatbot name"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required Field";
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      bool isValid = true;
                      if (_formKey.currentState?.validate() == false) {
                        isValid = false;
                      }

                      if (!isValid) return;

                      _formKey.currentState?.save();

                      ChatBotModel model =
                          await _chatbotAPI.createChatBot(_name);

                      Get.offNamed(
                        "/chat_page",
                        arguments: ChatbotPageArguments(model.id),
                      )!
                          .then(
                        (value) => _controller.reloadChats(),
                      );
                    },
                    child: const Text("Create"),
                  ),
                  const SizedBox(width: 15),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
