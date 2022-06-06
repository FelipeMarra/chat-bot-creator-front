import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String? name;
  final void Function(String value)? onChange;
  const TitleWidget({
    this.name,
    this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TextFormField(
            initialValue: name,
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
              if (onChange != null) {
                onChange!(value);
              }
            },
          ),
        ),
        Flexible(child: Container()),
      ],
    );
  }
}
