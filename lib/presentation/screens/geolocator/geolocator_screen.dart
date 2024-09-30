import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/geolocator/helpers/geolocator_helpers.dart';
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
    final position = determinePosition();

    return const Column(
      children: [],
    );
  }
}
