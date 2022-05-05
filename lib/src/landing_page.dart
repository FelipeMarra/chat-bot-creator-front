import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/src/home/home_page.dart';
import 'package:chat_bot_creator/src/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    API _api = context.watch<API>();
    Widget? child;

    //TODO not getting autentication afeter registration
    if (_api.initiated) {
      if (_api.user.isAutheticated) {
        child = const HomePage();
      } else {
        child = const LoginPage();
      }
    } else {
      child = const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: child,
    );
  }
}
