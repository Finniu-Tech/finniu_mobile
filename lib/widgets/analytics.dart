import 'package:finniu/presentation/providers/event_tracker_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnalyticsAwareWidget extends ConsumerStatefulWidget {
  final String screenName;
  final Widget child;

  const AnalyticsAwareWidget({
    super.key,
    required this.screenName,
    required this.child,
  });

  @override
  _AnalyticsAwareWidgetState createState() => _AnalyticsAwareWidgetState();
}

class _AnalyticsAwareWidgetState extends ConsumerState<AnalyticsAwareWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(eventTrackerServiceProvider).logScreenView(widget.screenName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
