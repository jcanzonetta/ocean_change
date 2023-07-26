import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    Navigator.pushNamed(context, CreateAccountScreen.routeName);
                  }, 
                  child: const Text("Create Account")),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Email"),
              // TO DO: Add validator
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
              // TO DO: Add validator
            ),
            ElevatedButton(onPressed: _signIn, child: const Text("Log In"))
          ],
        ),
      ),
    );
  }

  Future _signIn() async {
    formKey.currentState!.save();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }


  
}
