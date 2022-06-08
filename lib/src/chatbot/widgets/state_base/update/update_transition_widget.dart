import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:flutter/material.dart';

class UpdateTransitionWidget extends StatelessWidget {
  final StateTransitionModel model;
  const UpdateTransitionWidget(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateTransitionModel transitionModel = model;

    //TODO check if will be validated
    return Column(
      children: [
        //TODO show only the states that are present in the bot
        TextFormField(
          initialValue: model.transitionTo.toString(),
          decoration: const InputDecoration(
            label: Text("Transitino To"),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Required Field";
            }
            try {
              int.parse(value);
            } catch (e) {
              return "Value must be an integer";
            }
            return null;
          },
          onChanged: (value) {
            transitionModel.transitionTo = int.parse(value);
          },
        ),
      ],
    );
  }
}
