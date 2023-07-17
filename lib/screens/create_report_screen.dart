import 'dart:io';

import 'package:flutter/material.dart';

import '../models/user_report.dart';
import '../widgets/forms/date_time_form_field.dart';
import '../widgets/forms/image_form_field.dart';
import '../widgets/forms/number_of_observation_form_field.dart';
import '../widgets/forms/observation_stream_builder.dart';
import '../widgets/forms/submit_form_button.dart';
import '../widgets/forms/water_temperature_form_field.dart';

class CreateReportScreen extends StatefulWidget {
  static const String routeName = 'CreateReportScreen';

  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final formKey = GlobalKey<FormState>();
  final userReport = UserReport();
  File? image;

  @override
  void initState() {
    super.initState();
  }

  void updateImageCallback(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report an Observation')),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ObservationStreamBuilder(userReport: userReport),
            NumberOfObservationFormField(userReport: userReport),
            WaterTemperatureFormField(userReport: userReport),
            DateTimeFormField(userReport: userReport),
            ImageFormField(
                userReport: userReport,
                updateImageCallback: updateImageCallback),
            SubmitFormButton(
                formKey: formKey, userReport: userReport, image: image),
          ]),
        ),
      ),
    );
  }
}
