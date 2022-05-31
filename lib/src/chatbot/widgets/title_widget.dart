import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String? name;
  final void Function(String value) onChange;
  final String? Function(String? value) validator;
  final TextEditingController textController;
  const TitleWidget({
    this.name,
    required this.onChange,
    required this.validator,
    required this.textController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: textController,
            initialValue: name,
            decoration: const InputDecoration(
              label: Text("Chatbot name"),
            ),
            validator: (value) => validator(value),
            onChanged: (value) => onChange(value),
          ),
        ],
      ),
    );
  }
}
