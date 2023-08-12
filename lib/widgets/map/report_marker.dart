import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ocean_change/models/user_report.dart';

// Adds userReport to the default Marker widget so that the data can be passed
// through to the view report screen
class ReportMarker extends Marker {
  final UserReport userReport;
  ReportMarker(
      {super.key,
      required this.userReport,
      required super.builder,
      super.height,
      super.width})
      : super(
            point: LatLng(
                userReport.geopoint!.latitude, userReport.geopoint!.longitude));
}
