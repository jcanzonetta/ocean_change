import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_change/models/user_report.dart';

class SubmitFormButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final UserReport userReport;
  final File? image;

  const SubmitFormButton(
      {super.key, required this.formKey, required this.userReport, this.image});

  @override
  State<SubmitFormButton> createState() => _SubmitFormButton();
}

class _SubmitFormButton extends State<SubmitFormButton> {
  Future<String> uploadImage(File image) async {
    String fileName =
        '${widget.userReport.observation!}${DateFormat('MMddyyyy').format(widget.userReport.date!)}.jpg';

    // Upload image to Cloud Storage
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

    UploadTask uploadTask = storageReference.putFile(widget.image!);
    await uploadTask;

    // Receive url of photo
    return storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (widget.formKey.currentState?.validate() ?? true) {
            widget.formKey.currentState!.save();

            String? imageUrl;
            if (widget.image != null) {
              imageUrl = await uploadImage(widget.image!);
            }

            FirebaseFirestore.instance.collection('reports').add({
              'observation': widget.userReport.observation,
              'species': widget.userReport.species,
              'observation_number': widget.userReport.observationNumber,
              'water_temp': widget.userReport.waterTemp,
              'date': widget.userReport.date,
              'photo_url': imageUrl
            });

            Navigator.of(context).pop();
          }
        },
        icon: const Icon(Icons.cloud_circle),
        label: const Text('Submit'),
      ),
    );
  }
}
