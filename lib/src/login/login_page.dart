import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/models/login_model.dart';
import 'package:chat_bot_creator/api/models/user_model.dart';
import 'package:chat_bot_creator/api/user_api.dart';
import 'package:chat_bot_creator/src/home/home_page.dart';
import 'package:chat_bot_creator/src/registration/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserAPI _userAPI = context.read<API>().user;

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String _email = "";
    String _password = "";

    Widget buildEmailForm() {
      return TextFormField(
        decoration: const InputDecoration(
          label: Text("Email"),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field";
          }
          return null;
        },
        onSaved: (value) {
          _email = value ?? "";
        },
      );
    }

    Widget buildPasswordForm() {
      return TextFormField(
        decoration: const InputDecoration(
          label: Text("Password"),
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required field";
          }
          return null;
        },
        onSaved: (value) {
          _password = value ?? "";
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat Creator / Login",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildEmailForm(),
              const SizedBox(height: 30),
              buildPasswordForm(),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == false) {
                        return;
                      }

                      _formKey.currentState?.save();

                      LoginModel loginModel =
                          await _userAPI.getToken(_email, _password);

                      if (loginModel.hasError) {
                        _showDialog(
                          context,
                          "Ops! Something wrong is not right: Trying to get token...",
                          loginModel.getError,
                        );

                        return;
                      }

                      UserModel userSetted = await _userAPI.setUser(
                        email: _email,
                        accessToken: loginModel.accessToken,
                      );

                      if (userSetted.hasError) {
                        _showDialog(
                          context,
                          "Ops! Something wrong is not right: trying to set user...",
                          userSetted.getError,
                        );

                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 50),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegistrationPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create account",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }
}
