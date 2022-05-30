import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorDialog(context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        OutlinedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Ok"),
        ),
      ],
    ),
  );
}
