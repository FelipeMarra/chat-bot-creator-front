import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:chat_bot_creator/src/chatbot/controller/chat_bot_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateBaseWidget extends StatelessWidget {
  final StateBaseModel model;
  const StateBaseWidget(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatBotPageController _controller = Get.find();

    //TODO: aceitar imagens
    List<Text> messages = [];
    for (StateMessageModel message in model.messages) {
      messages.add(Text(message.message));
    }

    //TODO: get names isntead of ids
    List<Text> tansitions = [];
    for (StateTransitionModel transition in model.transitions) {
      tansitions.add(Text(transition.transitionTo.toString()));
    }

    return model.hasError
        ? Text(model.error!.message)
        : Column(
            children: [
              const Divider(),
              ListTile(
                //onTap: () => ,
                //leading: const Icon(Icons.state),
                title: Text(model.name),
                subtitle: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Messages:"),
                    ...messages,
                    const Text("Transitions:"),
                    ...tansitions
                  ],
                ),
                trailing: IconButton(
                  onPressed: () => _controller.deleteState(model),
                  icon: const Icon(Icons.delete),
                ),
              ),
            ],
          );
  }
}
