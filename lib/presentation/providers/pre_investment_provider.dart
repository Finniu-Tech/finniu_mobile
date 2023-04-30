// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final preInvestmentSave = FutureProvider.family<void, int>((ref, id) async {
//   try {
//     final preInvestmentRepository = ref.read(preInvestmentRepositoryProvider);
//     final client = ref.watch(gqlClientProvider).value;
//     final result = await preInvestmentRepository.save(
//       client: client!,
//       id: id,
//     );
//     return result;
//   } catch (e, stack) {
//     return Future.error('Error: $e', stack);
//   }
// });