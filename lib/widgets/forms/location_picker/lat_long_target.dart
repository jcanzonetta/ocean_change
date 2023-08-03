import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class LatLongTarget extends StatelessWidget {
  const LatLongTarget({
    super.key,
    required CustomPoint<double>? position,
  }) : _position = position;

  final CustomPoint<double>? _position;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _position!.x - 10,
        top: _position!.y - 10,
        height: 20,
        width: 20,
        child: const Icon(Icons.location_searching));
  }
}
