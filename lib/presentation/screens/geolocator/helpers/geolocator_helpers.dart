import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  try {
    return await Geolocator.getCurrentPosition();
  } catch (e) {
    return Future.error(e);
  }
}

Future<LocationPermission> getPermissionState() async {
  bool serviceEnabled;
  LocationPermission permissionStatus;
  try {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permissionStatus = await Geolocator.checkPermission();
    if (permissionStatus == LocationPermission.denied) {
      permissionStatus = await Geolocator.requestPermission();
      if (permissionStatus == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permissionStatus == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return permissionStatus;
  } catch (e) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }
}
