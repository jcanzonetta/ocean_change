import 'package:flutter/material.dart';

class ReportMarkerIcon extends StatelessWidget {
  final String? observation;
  const ReportMarkerIcon({super.key, required this.observation});

  @override
  // could add more images for different observations
  Widget build(BuildContext context) {
    if (observation == "Jellyfish") {
      return Image.asset('assets/images/jellyfish_icon.png');
    } else {
      return Image.asset('assets/images/generic_pin_icon.png');
    }
  }
}
