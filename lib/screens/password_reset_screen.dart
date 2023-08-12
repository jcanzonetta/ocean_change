import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/login/show_login_error.dart';

class PasswordResetScreen extends StatefulWidget {
  static const String routeName = 'PasswordResetScreen';
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final formKey = GlobalKey<FormState>();
  String email = "";

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
              const Center(
                  child:
                      Text("We can send a password reset link to your registered email.")),
              TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Please enter an email";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    email = value!;
                  }),
              ElevatedButton(
                  onPressed: _sendPasswordResetEmail,
                  child: const Text("Send Password Reset")),
            ],
          ),
        ),
      ),
    );
  }

  Future _sendPasswordResetEmail() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
            email: email);
      } on FirebaseAuthException catch (e) {
        showFireBaseAuthError(context, e.message!);
      }
    }
  }
}
