import 'package:chat_bot_creator/src/app_widget.dart';
import 'package:chat_bot_creator/src/hive_config.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(const MyApp());
}
