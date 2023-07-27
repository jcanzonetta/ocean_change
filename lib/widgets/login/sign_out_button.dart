import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _signOut();
      },
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: const Text('Sign Out'),
    );
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
