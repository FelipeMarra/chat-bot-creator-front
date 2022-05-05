import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/src/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => API()),
      ],
      child: MaterialApp(
        title: 'Chat Bot',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
