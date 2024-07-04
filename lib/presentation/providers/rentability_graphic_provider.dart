import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rentabilityGraphicFutureProvider =
    FutureProvider.autoDispose<RentabilityGraphicResponseAPI>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final timeLine = ref.watch(timePeriodProvider);
    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.rentabilityGraphic,
        ),
        variables: {"timeLine": timeLine.value},
      ),
    );
    List<RentabilityGraphicEntity> dataSoles =
        (result.data?['rentabilityGraph']['rentabilityInPen'] as List)
            .map(
              (e) => RentabilityGraphicEntity(
                amountPoint: e['amountPoint'].toString(),
                month: e['month'].toString(),
              ),
            )
            .toList();
    List<RentabilityGraphicEntity> dataUSD =
        (result.data?['rentabilityGraph']['rentabilityInUsd'] as List)
            .map(
              (e) => RentabilityGraphicEntity(
                amountPoint: e['amountPoint'].toString(),
                month: e['month'].toString(),
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

final timePeriodProvider =
    StateNotifierProvider<TimePeriodNotifier, TimePeriod>((ref) {
  return TimePeriodNotifier();
});
