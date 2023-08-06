import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ocean_change/models/user_report.dart';

class SubmitFormButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final UserReport userReport;
  final File? image;
  final Function clearImageCallback;

  const SubmitFormButton(
      {super.key,
      required this.formKey,
      required this.userReport,
      this.image,
      required this.clearImageCallback});

  @override
  State<SubmitFormButton> createState() => _SubmitFormButton();
}

class _SubmitFormButton extends State<SubmitFormButton> {
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
  }

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: _uploading
                ? null
                : () async {
                    if (widget.formKey.currentState?.validate() ?? true) {
                      setState(() {
                        _uploading = true;
                      });

                      widget.formKey.currentState!.save();

                      String? imageUrl;
                      if (widget.image != null) {
                        imageUrl = await uploadImage(widget.image!);
                      }

                      FirebaseFirestore.instance.collection('reports').add({
                        'observation': widget.userReport.observation,
                        'species': widget.userReport.species,
                        'observation_number':
                            widget.userReport.observationNumber,
                        'water_temp': widget.userReport.waterTemp,
                        'water_color': widget.userReport.waterColor,
                        'temperature_break': widget.userReport.temperatureBreak,
                        'activity': widget.userReport.activity,
                        'date': widget.userReport.date,
                        'photo_url': imageUrl,
                        'geopoint': widget.userReport.geopoint,
                        'user': FirebaseAuth.instance.currentUser?.email
                      });

                      widget.clearImageCallback;

                      if (context.mounted) Navigator.of(context).pop();
                    }
                  },
            icon: _uploading
                ? Transform.scale(
                    scale: 0.5,
                    child: const CircularProgressIndicator(color: Colors.white))
                : const Icon(Icons.cloud_circle),
            label: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
