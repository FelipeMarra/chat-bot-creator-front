import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:flutter/material.dart';

class NewMessageWidget extends StatelessWidget {
  NewMessageWidget({Key? key}) : super(key: key);

  final StateMessageModel messageModel = StateMessageModel(
    id: -1,
    stateId: -1,
    message: "",
    messageType: "text",
  );

  @override
  Widget build(BuildContext context) {
    //TODO check if will be validated
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            label: Text("Your Message"),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Required Field";
            }
            return null;
          },
          onChanged: (value) {
            messageModel.message = value;
          },
        ),
      ],
    );
  }
}
