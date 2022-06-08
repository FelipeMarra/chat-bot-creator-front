import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:chat_bot_creator/src/chatbot/controller/chat_bot_page_controller.dart';
import 'package:chat_bot_creator/src/chatbot/widgets/state_base/new_message_widget.dart';
import 'package:chat_bot_creator/src/chatbot/widgets/state_base/new_transition_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewStateBaseWidget extends StatefulWidget {
  final int chatbotId;
  const NewStateBaseWidget(this.chatbotId, {Key? key}) : super(key: key);

  @override
  State<NewStateBaseWidget> createState() => _NewStateBaseWidgetState();
}

class _NewStateBaseWidgetState extends State<NewStateBaseWidget> {
  final ChatBotPageController _chatController =
      Get.find<ChatBotPageController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int stateId = -1;
  String _name = "";
  final List<NewTransitionWidget> _transitionsWidgets = [];
  final List<NewMessageWidget> _messagesWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //Name
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  label: Text("State name"),
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
              const Text("Messages"),
              Column(
                children: _messagesWidgets,
              ),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _messagesWidgets.add(NewMessageWidget());
                  });
                },
                child: const Text("Add Transition"),
              ),
              const SizedBox(height: 15),
              const Text("Transitions"),
              Column(
                children: _transitionsWidgets,
              ),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _transitionsWidgets.add(NewTransitionWidget());
                  });
                },
                child: const Text("Add Transition"),
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

                      //Get messages
                      List<StateMessageModel> messages = [];

                      for (NewMessageWidget m in _messagesWidgets) {
                        messages.add(m.messageModel);
                      }

                      //Get transitions
                      List<StateTransitionModel> transitions = [];

                      for (NewTransitionWidget t in _transitionsWidgets) {
                        transitions.add(t.transitionModel);
                      }

                      StateBaseModel newState = StateBaseModel(
                        id: -1,
                        chatbotId: widget.chatbotId,
                        name: _name,
                        stateType: "dumb",
                        messages: messages,
                        transitions: transitions,
                      );

                      _chatController.createState(newState);

                      Get.back();
                    },
                    //TODO manda p criar mesmo invalido?
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
