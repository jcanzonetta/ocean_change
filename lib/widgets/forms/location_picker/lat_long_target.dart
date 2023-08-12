import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class LatLongTarget extends StatelessWidget {
  const LatLongTarget({
    super.key,
    required CustomPoint<double>? position,
  }) : _position = position;

  final CustomPoint<double>? _position;
  static const double iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _position!.x - iconSize / 2,
        top: _position!.y - iconSize,
        height: iconSize,
        width: iconSize,
        child: const Icon(
          Icons.add_location_outlined,
          size: iconSize,
        ));
  }
}
