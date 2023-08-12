import "package:flutter/material.dart";

// dialog pop up to tell the user a verification email has been sent
Future<void> showVerificationEmailSent(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Verification Email Sent'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
              Text("Check your email and tap the link we provided."),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}