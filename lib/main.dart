import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
   try {
     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080,sslEnabled: false);
     
     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099); 
     FirebaseAuth.instance.setSettings( appVerificationDisabledForTesting: true, forceRecaptchaFlow: true);
       } catch (e) {
     // ignore: avoid_print
     print(e);
   }
 }
  runApp(const App());
}
