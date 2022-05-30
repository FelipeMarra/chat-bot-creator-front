import 'package:flutter/material.dart';

class TitleWidget extends StatefulWidget {
  final String initialName;
  const TitleWidget(
    this.initialName, {
    Key? key,
  }) : super(key: key);

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name;

  @override
  void initState() {
    _name = widget.initialName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
          ],
        ),
      ),
    );
  }
}
