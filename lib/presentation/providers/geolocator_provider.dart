import 'package:finniu/presentation/screens/geolocator/helpers/geolocator_helpers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final geolocatorProvider =
    FutureProvider.autoDispose<GeolocatorProvider?>((ref) async {
  try {
    final permissionStatus = await getPermissionState();
    final position = await determinePosition();
    final lastPosition = await Geolocator.getLastKnownPosition();
    final state = GeolocatorProvider(
      position: position,
      permissionStatus: permissionStatus,
      lastPosition: lastPosition,
    );
    return state;
  } catch (e) {
    return null;
  }
});

class GeolocatorProvider {
  final Position? position;
  final Position? lastPosition;
  final LocationPermission permissionStatus;

  GeolocatorProvider({
    required this.position,
    required this.permissionStatus,
    required this.lastPosition,
  });
}
