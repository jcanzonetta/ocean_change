import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ocean_change/widgets/map/report_marker.dart';

class BaseMap extends StatefulWidget {
  const BaseMap({super.key});

  @override
  State<BaseMap> createState() => _BaseMapState();
}

class _BaseMapState extends State<BaseMap> {
  final mapController = MapController();
  List<Marker> reportMarkers = [];
  bool _markersReady = false;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(center: const LatLng(45.3, -125), zoom: 6.8),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dfw.state.or.us.oceanchange.app',
        ),
        MarkerLayer(
          markers: _generateMarkers(context),
        )
      ],
    );
  }

  List<Marker> _generateMarkers(BuildContext context) {
    if (_markersReady == false) {
      FirebaseFirestore.instance.collection('test_reports').get().then(
        (event) {
          for (var doc in event.docs) {
            final report = doc.data();
            reportMarkers.add(Marker(
                point: LatLng(report["Lat"], report["Long"]),
                width: 50,
                height: 50,
                builder: (context) => ReportMarker(
                      observation: report["Observation"],
                    )));
          }
          _markersReady = true;
          setState(() {});
        },
      );
    }
    return reportMarkers;    
  }
}
