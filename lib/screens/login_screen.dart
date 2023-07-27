import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_change/screens/create_account_screen.dart';
import '../models/user_data.dart';
import '../widgets/login/login_error_alert.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ocean Change')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 24, 0, 6),
                  child: Text("First time user?")),
              Padding(
                padding: const EdgeInsets.only(bottom: 48),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, CreateAccountScreen.routeName);
                    },
                    child: const Text("Create Account")),
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a username";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    userData.email = value!;
                  }),
              TextFormField(
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a password";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    userData.password = value!;
                  }),
              ElevatedButton(onPressed: _signIn, child: const Text("Log In"))
            ],
          ),
        ),
      ),
    );
  }

  Future _signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userData.email!, password: userData.password!);
      } on FirebaseAuthException catch (e) {
        showLoginError(context, e.message!);
      }
    }
  }
}

