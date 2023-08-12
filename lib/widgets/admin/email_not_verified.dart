import "package:flutter/material.dart";

// error dialog popup that displays when a user attempts to bypass the email verification screen
// without first verifying their email
Future<void> showEmailNotVerifiedError(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Email not yet Verified'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
              Text("Your email is not yet showing as verified. Be sure to click the link we sent. If you already have, perhaps our system is slow."),
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