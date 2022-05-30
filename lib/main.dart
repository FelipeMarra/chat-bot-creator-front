import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:chat_bot_creator/src/app_widget.dart';
import 'package:chat_bot_creator/src/hive_config.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(const MyApp());
}
