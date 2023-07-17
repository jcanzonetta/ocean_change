import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_report.dart';

class ImageFormField extends StatefulWidget {
  const ImageFormField(
      {super.key, required this.userReport, required this.updateImageCallback});

  final UserReport userReport;
  final Function(File) updateImageCallback;

  @override
  State<ImageFormField> createState() => _ImageFormFieldState();
}

class _ImageFormFieldState extends State<ImageFormField> {
  late File image;

  void getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      image = File(pickedImage.path);
      widget.updateImageCallback(image);
    } on PlatformException catch (error) {
      print('Unable to get image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;

        if (connected) {
          return OutlinedButton(
              onPressed: () async {
                getImage();
              },
              child: const Icon(Icons.photo));
        } else {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Image can only be uploaded while online.'),
          );
        }
      },
      child: const Text("Error: Image Picker"),
    );
  }
}
