// ignore_for_file: unused_local_variable
import 'package:chat_bot_creator/api/api.dart';
import 'package:chat_bot_creator/api/models/user_model.dart';
import 'package:chat_bot_creator/api/user_api.dart';
import 'package:chat_bot_creator/src/get_it_locator.dart';
import 'package:chat_bot_creator/src/home/home_page.dart';
import 'package:chat_bot_creator/src/login/login_page.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  static const routeName = "registration_page";

  @override
  Widget build(BuildContext context) {
    UserAPI _userAPI = locator.get<API>().user;

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _name = "";
    String _email = "";
    String _password = "";

    Widget buildNameField() {
      return TextFormField(
        decoration: const InputDecoration(
          label: Text("Nome"),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Campo Obrigatório";
          }
          return null;
        },
        onSaved: (value) {
          _name = value ?? "";
        },
      );
    }

    Widget buildEmailField() {
      return TextFormField(
        decoration: const InputDecoration(
          label: Text("Email"),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Campo Obrigatório";
          }
          return null;
        },
        onSaved: (value) {
          _email = value ?? "";
        },
      );
    }

    Widget buildPasswordField() {
      return TextFormField(
        decoration: const InputDecoration(
          label: Text("Senha"),
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Campo Obrigatório";
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
          "Emo Robot Chat / Registrar-se",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () =>
              Navigator.of(context).popAndPushNamed(LoginPage.routeName),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildNameField(),
              const SizedBox(height: 30),
              buildEmailField(),
              const SizedBox(height: 30),
              buildPasswordField(),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 50),
                  OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == false) {
                        return;
                      }

                      _formKey.currentState?.save();

                      UserModel user =
                          await _userAPI.createUser(_name, _email, _password);

                      if (user.error != null) {
                        _showDialog(
                          context,
                          "Ops! Algo de errado não está certo...",
                          user.getError,
                        );

                        return;
                      }

                      Navigator.of(context).popAndPushNamed(HomePage.routeName);
                    },
                    child: const Text(
                      "Criar",
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
