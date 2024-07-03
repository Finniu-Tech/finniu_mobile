import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rentabilityGraphFutureProvider =
    FutureProvider.autoDispose<RentabilityGraphResponseAPI>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final timeLine = ref.watch(timePeriodProvider);
    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.rentabilityGraph,
        ),
        variables: {"timeLine": timeLine.value},
      ),
    );
    List<RentabilityGraphEntity> dataSoles =
        (result.data?['rentabilityGraph']['rentabilityInPen'] as List)
            .map(
              (e) => RentabilityGraphEntity(
                amountPoint: e['amountPoint'].toString(),
                month: e['month'].toString(),
              ),
            )
            .toList();
    List<RentabilityGraphEntity> dataUSD =
        (result.data?['rentabilityGraph']['rentabilityInUsd'] as List)
            .map(
              (e) => RentabilityGraphEntity(
                amountPoint: e['amountPoint'].toString(),
                month: e['month'].toString(),
              ),
            )
            .toList();
    return RentabilityGraphResponseAPI(
      rentabilityInPen: dataSoles,
      rentabilityInUsd: dataUSD,
    );
  } catch (e) {
    return RentabilityGraphResponseAPI(
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

final timePeriodProvider =
    StateNotifierProvider<TimePeriodNotifier, TimePeriod>((ref) {
  return TimePeriodNotifier();
});
