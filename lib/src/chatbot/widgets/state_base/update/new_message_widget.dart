import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:flutter/material.dart';

class UpdateMessageWidget extends StatelessWidget {
  final StateMessageModel model;
  const UpdateMessageWidget(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StateMessageModel messageModel = model;

    //TODO check if will be validated
    return Column(
      children: [
        TextFormField(
          initialValue: model.message,
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
