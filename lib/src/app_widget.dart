import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/src/chatbot/chatbot_page.dart';
import 'package:chat_bot_creator/src/home/home_page.dart';
import 'package:chat_bot_creator/src/landing_page.dart';
import 'package:chat_bot_creator/src/login/login_page.dart';
import 'package:chat_bot_creator/src/registration/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat Bot',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      getPages: [
        GetPage(name: "/", page: () => const LandingPage()),
        GetPage(name: LoginPage.routeName, page: () => const LoginPage()),
        GetPage(
            name: RegistrationPage.routeName,
            page: () => const RegistrationPage()),
        GetPage(name: HomePage.routeName, page: () => const HomePage()),
        GetPage(
          name: ChatbotPage.routeName,
          page: () => ChatbotPage(Get.arguments),
        ),
      ],
    );
  }
}
