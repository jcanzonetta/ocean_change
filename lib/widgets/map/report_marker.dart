import 'package:flutter/material.dart';

class ReportMarker extends StatelessWidget {
  const ReportMarker({super.key, required this.observation});

  final String observation;

  @override
  Widget build(BuildContext context) {
    if (observation == "Jellyfish") {
      return Image.asset('assets/images/jellyfish_icon.png');
    } else {
      return Image.asset('assets/images/generic_pin_icon.png');
    }
  }
}
