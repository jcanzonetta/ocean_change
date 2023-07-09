import 'package:flutter/material.dart';

class ViewReportScreen extends StatelessWidget {
  static const String routeName = 'ViewReportScreen';

  const ViewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Placeholder Text (reads from Firestore)')),
      body: const Placeholder(),
    );
  }
}
