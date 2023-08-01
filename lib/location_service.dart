import 'package:geolocator/geolocator.dart';

class LocationService {
  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream();
  }

  void checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission newPermission = await Geolocator.requestPermission();
      if (newPermission == LocationPermission.denied ||
          newPermission == LocationPermission.deniedForever) {
        // Handle permission denial
      }
    }
  }
}
