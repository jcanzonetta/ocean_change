import 'package:flutter/material.dart';

import '../models/user_report.dart';
import '../widgets/forms/date_time_form_field.dart';
import '../widgets/forms/observation_form_field.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report an Observation')),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ObservationFormField(userReport: userReport),
            WaterTemperatureFormField(userReport: userReport),
            DateTimeFormField(userReport: userReport),
            SubmitFormButton(formKey: formKey, userReport: userReport),
          ]),
        ),
      ),
    );
  }
}
