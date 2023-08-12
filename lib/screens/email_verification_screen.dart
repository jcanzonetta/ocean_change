import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_change/widgets/admin/email_not_verified.dart';
import 'package:ocean_change/widgets/admin/verification_email_sent.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const String routeName = 'CreateAccountScreen';
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    currentUser!.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Ocean Change')),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Before logging in, we need to verify your email."),
            const Text("We sent a verification email to your inbox."),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text("Please click the link inside."),
            ),
            const Text("Didn't receive the verification email?"),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                  onPressed: () {
                    currentUser!.sendEmailVerification();
                    showVerificationEmailSent(context);
                  },
                  child: const Text("Resend Verification Email")),
            ),
            const Text("Finished verifying your email?"),
            ElevatedButton(
                onPressed: () {
                  currentUser!.reload();
                  // delay to not throw error unless not verified
                  Future.delayed(const Duration(seconds: 1), () => showEmailNotVerifiedError(context));
                },
                child: const Text("Proceed to the App"))
          ]),
        ));
  }
}
