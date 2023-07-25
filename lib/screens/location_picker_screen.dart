import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ocean_change/models/user_report.dart';

class LocationPickerScreen extends StatefulWidget {
  static const String routeName = 'LocationPickerScreen';

  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  CustomPoint<double>? _position = const CustomPoint(10, 10);

  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final UserReport userReport =
        ModalRoute.of(context)?.settings.arguments as UserReport;

    return Scaffold(
      appBar: AppBar(title: const Text('Where was this observed?')),
      body: Stack(children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
              onPositionChanged: (mapPosition, someBool) {
                final updatedLatLng = LatLng(userReport.geopoint!.latitude,
                    userReport.geopoint!.longitude);

                _position = _mapController.latLngToScreenPoint(updatedLatLng);

                setState(() {});
                imageCache.clear();
                // imageCache.clearLiveImages();
              },
              onMapReady: () {
                if (userReport.geopoint != null) {
                  _position = _mapController.latLngToScreenPoint(LatLng(
                      userReport.geopoint!.latitude,
                      userReport.geopoint!.longitude));
                } else {
                  final centerLatLng = _mapController.center;
                  _position = _mapController.latLngToScreenPoint(centerLatLng);
                  userReport.geopoint =
                      GeoPoint(centerLatLng.latitude, centerLatLng.longitude);
                }
                setState(() {});
              },
              center: LatLng(45.3, -125),
              zoom: 6,
              maxZoom: 11,
              minZoom: 5,
              maxBounds:
                  LatLngBounds(LatLng(35.65, -140.10), LatLng(50.80, -120.50)),
              onTap: (tapPos, latLng) {
                debugPrint('x: ${_position?.x} y: ${_position?.y}');

                _position = _mapController.latLngToScreenPoint(latLng);

                userReport.geopoint =
                    GeoPoint(latLng.latitude, latLng.longitude);

                debugPrint(
                    'x: ${userReport.geopoint!.latitude}, y: ${userReport.geopoint!.longitude}');

                setState(() {
                  _position = _mapController.latLngToScreenPoint(latLng);
                });
              }),
          children: [
            TileLayer(
              tileProvider: AssetTileProvider(),
              urlTemplate: 'assets/map/{z}/{x}/{y}.png',
              tms: false,
            )
          ],
        ),
        Positioned(
            left: _position!.x - 10,
            top: _position!.y - 10,
            height: 20,
            width: 20,
            child: const Icon(Icons.location_searching))
      ]),
    );
  }
}
