import 'dart:io';
import 'package:flutter/material.dart';

import 'package:ocean_change/widgets/login/sign_out_button.dart';
import '../models/user_report.dart';
import '../widgets/forms/activity_stream_builder.dart';
import '../widgets/forms/date_time_form_field.dart';
import '../widgets/forms/image_form_field.dart';
import '../widgets/forms/location_picker_form_field.dart';
import '../widgets/forms/number_of_observation_form_field.dart';
import '../widgets/forms/observation_stream_builder.dart';
import '../widgets/forms/submit_form_button.dart';
import '../widgets/forms/temperature_break_form_field.dart';
import '../widgets/forms/water_color_form_field.dart';
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

  void clearImageCallback() {
    setState(() {
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report an Observation'),
        actions: const [SignOutButton()],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ObservationStreamBuilder(userReport: userReport),
              NumberOfObservationFormField(userReport: userReport),
              WaterTemperatureFormField(userReport: userReport),
              WaterColorFormField(userReport: userReport),
              TemperatureBreakFormField(userReport: userReport),
              ActivityStreamBuilder(userReport: userReport),
              DateTimeFormField(userReport: userReport),
              LocationPickerFormField(userReport: userReport),
              ImageFormField(
                  userReport: userReport,
                  updateImageCallback: updateImageCallback),
              SubmitFormButton(
                  formKey: formKey,
                  userReport: userReport,
                  image: image,
                  clearImageCallback: clearImageCallback),
            ]),
          ),
        ),
      ),
    );
  }
}
