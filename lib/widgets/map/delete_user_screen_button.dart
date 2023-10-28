import 'package:flutter/material.dart';
import 'package:ocean_change/screens/delete_user_screen.dart';

class DeleteUserButton extends StatelessWidget {
  const DeleteUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DeleteUserScreen()));
      },
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: const Text('DeleteUser'),
    );
  }
}
