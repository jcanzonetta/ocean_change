import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:ocean_change/models/user_report.dart';

class ImageFormField extends StatelessWidget {
  const ImageFormField({super.key, required this.userReport});

  final UserReport userReport;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(connected ? 'online' : 'offline'),
        );
      },
      child: const Text("Error: Image Picker"),
    );
  }
}
