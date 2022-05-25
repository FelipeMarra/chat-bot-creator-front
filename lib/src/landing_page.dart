import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/src/get_it_locator.dart';
import 'package:chat_bot_creator/src/home/home_page.dart';
import 'package:chat_bot_creator/src/login/login_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    API _api = locator.get<API>();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await _api.init();

      if (_api.user.isAutheticated) {
        Navigator.of(context).popAndPushNamed(HomePage.routeName);
      } else {
        Navigator.of(context).popAndPushNamed(LoginPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
