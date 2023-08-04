import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

import 'popup.dart';
import 'report_popup.dart';
import 'report_marker.dart';

class BaseMap extends StatefulWidget {
  final List<ReportMarker> reportMarkers;
  BaseMap({super.key, required this.reportMarkers});

  @override
  State<BaseMap> createState() => _BaseMapState();
}

class _BaseMapState extends State<BaseMap> {
  final mapController = MapController();
  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        onPositionChanged: (mapPosition, someBool) {
          imageCache.clear();
          _popupLayerController.hideAllPopups();
        },
        center: LatLng(45.3, -125),
        zoom: 6,
        maxZoom: 11,
        minZoom: 5,
        maxBounds: LatLngBounds(LatLng(35.65, -140.10), LatLng(50.80, -120.50)),
        interactiveFlags: InteractiveFlag.doubleTapZoom |
            InteractiveFlag.drag |
            InteractiveFlag.pinchMove |
            InteractiveFlag.pinchZoom |
            InteractiveFlag.flingAnimation,
        onTap: (_, __) => _popupLayerController.hideAllPopups(),
      ),
      children: [
        TileLayer(
          tileProvider: AssetTileProvider(),
          urlTemplate: 'assets/map/{z}/{x}/{y}.png',
          tms: false,
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
              markers: widget.reportMarkers,
              popupController: _popupLayerController,
              popupBuilder: (BuildContext context, Marker marker) {
                if (marker is ReportMarker) {
                  return ReportPopUp(marker, marker.userReport);
                } else {
                  return PopUp(marker);
                }
              }),
        )
      ],
    );
  }
}
