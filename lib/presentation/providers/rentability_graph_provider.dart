import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rentabilityGraphFutureProvider =
    FutureProvider.autoDispose<RentabilityGraphResponseAPI>((ref) async {
  try {
    final client = ref.watch(gqlClientProvider).value;
    final result = await client!.query(
      QueryOptions(
        document: gql(
          QueryRepository.rentabilityGraph,
        ),
        variables: const {"timeLine": "all_months"},
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
