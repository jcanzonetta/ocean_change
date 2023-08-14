import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_change/screens/create_account_screen.dart';
import 'package:ocean_change/screens/password_reset_screen.dart';
import '../models/user_data.dart';
import '../widgets/login/show_login_error.dart';
import '../widgets/login/google_sign_in_button.dart';

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
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Platform.isAndroid ? const GoogleSignInButton() : Container(),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 6),
                  child: Platform.isAndroid
                      ? const Text("Or sign in with email and password.")
                      : const Text('Sign in with email and password.')),
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
              ElevatedButton(
                  onPressed: _emailSignIn, child: const Text("Sign In")),
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(
                      context, PasswordResetScreen.routeName),
                  child: const Text("Forgot Password?")),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 6),
                  child: Platform.isAndroid
                      ? const Text(
                          "New user who can't sign in with a Google account?")
                      : Container()),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, CreateAccountScreen.routeName);
                    },
                    child: const Text("Create Account")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _emailSignIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userData.email!, password: userData.password!);
      } on FirebaseAuthException catch (e) {
        showFireBaseAuthError(context, e.message!);
      }
    }
  }
}
