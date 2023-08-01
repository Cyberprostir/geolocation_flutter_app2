import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import 'dart:async';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  LocationService _locationService = LocationService();
  StreamSubscription<Position>? _positionStreamSubscription;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initLocationService();
  }

  void _initLocationService() {
    _locationService.checkPermission();
    _positionStreamSubscription =
        _locationService.getLocationStream().listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void _startTracking() {
    setState(() {
      _positionStreamSubscription?.cancel();
      _positionStreamSubscription =
          _locationService.getLocationStream().listen((position) {
        setState(() {
          _currentPosition = position;
        });
      });
    });
  }

  void _stopTracking() {
    _positionStreamSubscription?.cancel();
    setState(() {
      _currentPosition = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocation Tracking App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentPosition != null)
              Text(
                'Latitude: ${_currentPosition!.latitude}\nLongitude: ${_currentPosition!.longitude}',
                textAlign: TextAlign.center,
              ),
            ElevatedButton(
              onPressed: _startTracking,
              child: Text('Start Tracking'),
            ),
            ElevatedButton(
              onPressed: _stopTracking,
              child: Text('Stop Tracking'),
            ),
          ],
        ),
      ),
    );
  }
}
