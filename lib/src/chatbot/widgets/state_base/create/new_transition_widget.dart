import 'package:chat_bot_creator/api/models/states_models.dart';
import 'package:flutter/material.dart';

class NewTransitionWidget extends StatelessWidget {
  NewTransitionWidget({Key? key}) : super(key: key);

  final StateTransitionModel transitionModel = StateTransitionModel(
    id: -1,
    stateId: -1,
    transitionTo: -1,
  );

  @override
  Widget build(BuildContext context) {
    //TODO check if will be validated
    return Column(
      children: [
        //TODO show only the states that are present in the bot
        TextFormField(
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
