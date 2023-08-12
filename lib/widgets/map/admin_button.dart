import 'package:flutter/material.dart';
import '../../screens/admin_screen.dart';

class AdminButton extends StatelessWidget {
  const AdminButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, AdminScreen.routeName);
      },
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: const Text('Admin'),
    );
  }
}

