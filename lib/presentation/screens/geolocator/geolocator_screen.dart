import 'package:finniu/presentation/providers/geolocator_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GeolocatorScreen extends StatelessWidget {
  const GeolocatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldConfig(
      title: "Geolocalización",
      children: _BodyGeolocator(),
    );
  }
}

class _BodyGeolocator extends ConsumerWidget {
  const _BodyGeolocator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(geolocatorProvider);
    return position.when(
      data: (data) => Center(
        child: Column(
          children: [
            const TextPoppins(text: "Ubicacion actual", fontSize: 20),
            ContainerPositions(
              latitude: data?.position?.latitude.toString() ?? "",
              longitude: data?.position?.longitude.toString() ?? "",
            ),
            const SizedBox(height: 20),
            const TextPoppins(
              text: "ultima ubicacion disponible",
              fontSize: 20,
            ),
            ContainerPositions(
              latitude: data?.lastPosition?.latitude.toString() ?? "",
              longitude: data?.lastPosition?.longitude.toString() ?? "",
            ),
            const SizedBox(height: 20),
            const TextPoppins(
              text: "estado de los permisos",
              fontSize: 20,
            ),
            Container(
              width: 350,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.shade300,
              ),
              child: TextPoppins(
                text: "Permission: ${data?.permissionStatus}",
                fontSize: 16,
                align: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      error: (error, stack) => Text(error.toString()),
      loading: () => const Center(
        child: CircularLoader(width: 50, height: 50),
      ),
    );
  }
}

class ContainerPositions extends StatelessWidget {
  const ContainerPositions({
    super.key,
    required this.latitude,
    required this.longitude,
  });
  final String latitude;
  final String longitude;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey.shade300,
      ),
      child: TextPoppins(
        text: "latitude: $latitude, longitude: $longitude",
        fontSize: 16,
        align: TextAlign.center,
      ),
    );
  }
}
