import "package:flutter/material.dart";


Future<void> showUserNotFoundError(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('User Not Found'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(message),
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