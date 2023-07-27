import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_change/screens/login_screen.dart';
import 'package:ocean_change/screens/map_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = '/';
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Navigator.maybePop(context);
            return const MapScreen();
          } else {
            Navigator.maybePop(context);
            return const LoginScreen();
          }
        });
  }
}
