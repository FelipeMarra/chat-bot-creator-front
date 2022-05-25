import 'package:chat_bot_creator/src/chatbot/chatbot_page.dart';
import 'package:chat_bot_creator/src/home/home_page.dart';
import 'package:chat_bot_creator/src/landing_page.dart';
import 'package:chat_bot_creator/src/login/login_page.dart';
import 'package:chat_bot_creator/src/registration/registration_page.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Bot',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routes: {
        "/": (context) => const LandingPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegistrationPage.routeName: (context) => const RegistrationPage(),
        HomePage.routeName: (context) => const HomePage(),
        ChatbotPage.routeName: (context) => ChatbotPage(ModalRoute.of(context)!.settings.arguments as ChatbotPageArguments),
      },
    );
  }
}
