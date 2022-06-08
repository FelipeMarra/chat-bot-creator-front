import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:chat_bot_creator/src/chatbot/controller/chat_bot_page_controller.dart';
import 'package:chat_bot_creator/src/chatbot/widgets/state_base/create/new_message_widget.dart';
import 'package:chat_bot_creator/src/chatbot/widgets/state_base/create/new_transition_widget.dart';
import 'package:chat_bot_creator/src/chatbot/widgets/state_base/update/new_message_widget.dart';
import 'package:chat_bot_creator/src/chatbot/widgets/state_base/update/update_transition_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStateBaseWidget extends StatefulWidget {
  final StateBaseModel model;
  const UpdateStateBaseWidget(this.model, {Key? key}) : super(key: key);
  @override
  State<UpdateStateBaseWidget> createState() => _UpdateStateBaseWidgetState();
}

class _UpdateStateBaseWidgetState extends State<UpdateStateBaseWidget> {
  final ChatBotPageController _chatController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<UpdateTransitionWidget> _transitionsWidgets = [];
  final List<UpdateMessageWidget> _messagesWidgets = [];

  final List<NewTransitionWidget> _newTransitionsWidgets = [];
  final List<NewMessageWidget> _newMessagesWidgets = [];

  @override
  void initState() {
    for (StateTransitionModel t in widget.model.transitions) {
      _transitionsWidgets.add(UpdateTransitionWidget(t));
    }
    for (StateMessageModel m in widget.model.messages) {
      _messagesWidgets.add(UpdateMessageWidget(m));
    }
    super.initState();
  }

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
              //Name
              TextFormField(
                initialValue: widget.model.name,
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
                  widget.model.name = value;
                },
              ),
              const SizedBox(height: 15),
              const Text("Messages"),
              Column(
                children: [
                  ..._messagesWidgets,
                  ..._newMessagesWidgets,
                ],
              ),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _newMessagesWidgets.add(NewMessageWidget());
                  });
                },
                child: const Text("Add Message"),
              ),
              const Text("Transitions"),
              Column(
                children: [
                  ..._transitionsWidgets,
                  ..._newTransitionsWidgets,
                ],
              ),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _newTransitionsWidgets.add(NewTransitionWidget());
                  });
                },
                child: const Text("Add Transition"),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      bool isValid = true;
                      if (_formKey.currentState?.validate() == false) {
                        isValid = false;
                      }

                      if (!isValid) return;

                      _formKey.currentState?.save();

                      for (NewMessageWidget m in _newMessagesWidgets) {
                        widget.model.messages.add(m.messageModel);
                      }

                      for (NewTransitionWidget t in _newTransitionsWidgets) {
                        widget.model.transitions.add(t.transitionModel);
                      }

                      _chatController.updateState(widget.model);

                      Get.back();
                    },
                    //TODO manda p criar mesmo invalido?
                    child: const Text("Update"),
                  ),
                  const SizedBox(width: 15),
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
