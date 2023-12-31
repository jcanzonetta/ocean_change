import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:ocean_change/styles.dart';
import 'package:ocean_change/widgets/view_report/delete_report_button.dart';
import '../../models/user_report.dart';
import '../../widgets/view_report/view_screen_args.dart';

class ViewReportData extends StatefulWidget {
  final ViewScreenArgs viewScreenArgs;

  const ViewReportData({super.key, required this.viewScreenArgs});

  @override
  State<ViewReportData> createState() => _ViewReportDataState();
}

class _ViewReportDataState extends State<ViewReportData> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late File image;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(child: loadImage(widget.viewScreenArgs.userReport.photoURL)),
      Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              children: [
                const Text('Observation:',
                    style: Styles.viewScreenObservationLabels),
                Text(
                  ' ${widget.viewScreenArgs.userReport.observation}',
                  style: Styles.viewScreenObservationData,
                ),
              ],
            ),
          )),
      Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        child: Row(
          children: [
            const Text('Number Observed:',
                style: Styles.viewScreenMediumLabels),
            Text(' ${widget.viewScreenArgs.userReport.observationNumber}',
                style: Styles.viewScreenMediumData),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        child: Row(
          children: [
            const Text('Date: ', style: Styles.viewScreenMediumLabels),
            Text(
                '${widget.viewScreenArgs.userReport.date!.month}/${widget.viewScreenArgs.userReport.date!.day}/${widget.viewScreenArgs.userReport.date!.year}',
                style: Styles.viewScreenMediumData),
            const Expanded(
                child: Text(' Time:',
                    style: Styles.viewScreenMediumLabels,
                    textAlign: TextAlign.right)),
            Text(
                ' ${widget.viewScreenArgs.userReport.date.toString().substring(11, 19)}',
                style: Styles.viewScreenMediumData,
                textAlign: TextAlign.right)
          ],
        ),
      ),
      loadWaterTemp(widget.viewScreenArgs.userReport.waterTemp),
      Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Water Color: ', style: Styles.viewScreenSmallLabels),
              Text(widget.viewScreenArgs.userReport.waterColor ?? 'none',
                  style: Styles.viewScreenSmallData),
            ],
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Temperature/transition break: ',
                  style: Styles.viewScreenSmallLabels),
              widget.viewScreenArgs.userReport.temperatureBreak ?? false
                  ? const Text('Yes', style: Styles.viewScreenSmallData)
                  : const Text('No', style: Styles.viewScreenSmallData),
            ],
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Activity: ', style: Styles.viewScreenSmallLabels),
              Text(
                widget.viewScreenArgs.userReport.activity ?? 'none',
                style: Styles.viewScreenSmallData,
              ),
            ],
          )),
      Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        child: Row(
          children: [
            const Text('Location:', style: Styles.viewScreenSmallLabels),
            Text(
              ' ${double.parse(widget.viewScreenArgs.userReport.geopoint!.latitude.toStringAsFixed(2))}° N, ${double.parse(widget.viewScreenArgs.userReport.geopoint!.longitude.toStringAsFixed(4))}° W',
              style: Styles.viewScreenSmallData,
            ),
          ],
        ),
      ),
      addPhotoButton(context, currentUser, widget.viewScreenArgs.userReport,
          widget.viewScreenArgs.adminStatus),
      DeleteReportButton(currentUser: currentUser, userReport: widget.viewScreenArgs.userReport,
          adminStatus: widget.viewScreenArgs.adminStatus)
    ]);
  }

  Widget loadImage(imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container();
    } else {
      return Image.network(imageUrl);
    }
  }

  Widget loadWaterTemp(waterTempReported) {
    if (waterTempReported == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        child: Row(
          children: [
            const Text('Water Temperature:',
                style: Styles.viewScreenSmallLabels),
            Text(' $waterTempReported°F', style: Styles.viewScreenSmallData),
          ],
        ),
      );
    }
  }

  Widget addPhotoButton(BuildContext context, User? currentUser,
      UserReport userReport, bool adminStatus) {
    if (currentUser?.email == userReport.user) {
      return ElevatedButton(
          onPressed: () async {
            addPhoto(context, userReport);
          },
          child: const Text("Add or Swap Photo"));
    } else {
      return Container();
    }
  }

  void addPhoto(BuildContext context, UserReport userReport) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      image = File(pickedImage.path);
      //widget.updateImageCallback(image);
    } on PlatformException catch (error) {
      debugPrint('Unable to get image: $error');
    }

    String? imageUrl;
    imageUrl = await uploadNewImage(image, userReport);

    FirebaseFirestore.instance
        .collection("reports")
        .doc(userReport.id)
        .update({"photo_url": imageUrl});

    setState(() {
      userReport.photoURL = imageUrl;
    });
  }

  Future<String> uploadNewImage(File image, UserReport userReport) async {
    if (userReport.photoURL != null) {
      final imageRef =
          FirebaseStorage.instance.refFromURL(userReport.photoURL.toString());
      await imageRef.delete();
    }
    int uniqueFileId = DateTime.now().millisecondsSinceEpoch;
    String fileName =
        '${widget.viewScreenArgs.userReport.observation!}${DateFormat('MMddyyyy').format(widget.viewScreenArgs.userReport.date!)}$uniqueFileId.jpg';

    // Upload image to Cloud Storage
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;

    // Receive url of photo
    return storageReference.getDownloadURL();
  }
}
