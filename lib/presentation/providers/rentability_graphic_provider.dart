import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RentabilityParamsProvider {
  final String timeline;
  final String fundUUID;
  RentabilityParamsProvider({required this.timeline, required this.fundUUID});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RentabilityParamsProvider &&
          runtimeType == other.runtimeType &&
          timeline == other.timeline &&
          fundUUID == other.fundUUID;

  @override
  int get hashCode => timeline.hashCode ^ fundUUID.hashCode;
}

final rentabilityGraphicFutureProvider =
    FutureProvider.autoDispose.family<RentabilityGraphicResponseAPI, RentabilityParamsProvider>((ref, params) async {
  final timeline = params.timeline;
  final fundUUID = params.fundUUID;

  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.rentabilityGraphic,
        ),
        fetchPolicy: FetchPolicy.noCache,
        variables: {"timeLine": timeline, "fundUUID": fundUUID},
      ),
    );

    List<RentabilityGraphicEntity> dataSoles = (result.data?['rentabilityGraph']['rentabilityInPen'] as List)
        .map(
          (e) => RentabilityGraphicEntity(
            amountPoint: e['amountPoint'].toString(),
            month: e['month'].toString(),
            date: e['date'].toString(),
          ),
        )
        .toList();

    List<RentabilityGraphicEntity> dataUSD = (result.data?['rentabilityGraph']['rentabilityInUsd'] as List)
        .map(
          (e) => RentabilityGraphicEntity(
            amountPoint: e['amountPoint'].toString(),
            month: e['month'].toString(),
            date: e['date'].toString(),
          ),
        )
        .toList();

    return RentabilityGraphicResponseAPI(
      rentabilityInPen: dataSoles,
      rentabilityInUsd: dataUSD,
    );
  } catch (e) {
    return RentabilityGraphicResponseAPI(
      rentabilityInPen: [],
      rentabilityInUsd: [],
      success: false,
    );
  }
});

class TimePeriodNotifier extends StateNotifier<TimePeriod> {
  TimePeriodNotifier() : super(TimePeriod.midYear);
  void setTimePeriod(TimePeriod newTimePeriod) {
    state = newTimePeriod;
  }
}

final timePeriodProvider = StateNotifierProvider<TimePeriodNotifier, TimePeriod>((ref) {
  return TimePeriodNotifier();
});
