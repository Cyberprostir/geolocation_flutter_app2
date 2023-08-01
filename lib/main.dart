import 'package:flutter/material.dart';
import 'tracking_screen.dart';

void main() => runApp(GeolocationTrackingApp());

class GeolocationTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrackingScreen(),
    );
  }
}
