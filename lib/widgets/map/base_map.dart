import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:ocean_change/screens/map_screen.dart';
import 'package:ocean_change/widgets/map/popup.dart';
import 'package:ocean_change/widgets/map/report_marker.dart';

class BaseMap extends StatefulWidget {
  const BaseMap({super.key});

  @override
  State<BaseMap> createState() => _BaseMapState();
}

class _BaseMapState extends State<BaseMap> {
  final mapController = MapController();
  List<Marker> reportMarkers = [];

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(center: LatLng(45.3, -125), zoom: 6.8),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dfw.state.or.us.oceanchange.app',
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            markers: generateMarkers(context),
            popupBuilder: (BuildContext context, Marker marker) => PopUp(marker),
          ),
        )
      ],
    );
  }

  List<Marker> generateMarkers(BuildContext context) {
    // reaches up to map screen to determine if it should generate markers
    MapScreenState? mapScreenState =
        context.findAncestorStateOfType<MapScreenState>();
    if (mapScreenState?.markersReady == false) {
      reportMarkers.clear();
      FirebaseFirestore.instance.collection('test_reports').get().then(
        (event) {
          for (var doc in event.docs) {
            final report = doc.data();
            reportMarkers.add(Marker(
                point:
                    LatLng(report["Lat"].toDouble(), report["Long"].toDouble()),
                width: 50,
                height: 50,
                builder: (context) => ReportMarker(
                      observation: report["Observation"],
                    )));
          }
          mapScreenState?.toggleMarkersReady();
          setState(() {});
        },
      );
    }
    return reportMarkers;
  }
}
