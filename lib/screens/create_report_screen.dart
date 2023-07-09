import 'package:flutter/material.dart';

class CreateReportScreen extends StatelessWidget {
  static const String routeName = 'CreateReportScreen';

  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report an Observation')),
      body: const Placeholder(),
    );
  }
}
