import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_change/screens/login_screen.dart';
import 'package:ocean_change/screens/map_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = '/';
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ocean Change')),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MapScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
