import 'package:finniu/domain/entities/onboarding_entities.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/onboarding_repository_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final startOnboardingProvider =
//     StateNotifierProvider<OnboardingStateNotifier, OnboardingEntity>(
//   (ref) {
//     final client = ref.watch(gqlClientProvider).value;
//     final userId = ref.watch(userProfileNotifierProvider).id;
//     final fetchOnboardingData =
//         ref.watch(onboardingRepositoryProvider).getOnboardingData;

//     return OnboardingNotifier(_state, fetchOnboardingData: fetchOnboardingData);
//     // return OnboardingNotifier(
//     //   OnboardingEntity(
//     //     totalQuestions: 0,
//     //     totalCompletedQuestions: 0,
//     //     questions: [],
//     //   ),
//     //   userId: ref.watch(userProfileNotifierProvider).id!,
//     //   client: ref.watch(gqlClientProvider).value!,
//     // );
//   },
// );

// final startOnBoardingStateNotifierProvider =
//     StateNotifierProvider<OnboardingStateNotifier, OnboardingEntity>((ref) {
//   final client = ref.watch(gqlClientProvider).value;
//   final userId = ref.watch(userProfileNotifierProvider).id;
//   final onboardingData = ref
//       .watch(onboardingRepositoryProvider)
//       .getOnboardingData(client: client!, userId: userId!);

//   onboardingData.then((value) {
//     ref.read(onBoardingStateNotifierProvider.notifier).updateFields(
//           totalQuestions: value.totalQuestions,
//           totalCompletedQuestions: value.totalCompletedQuestions,
//           questions: value.questions,
//         );
//   });

final startOnBoardingStateNotifierProvider = FutureProvider<OnboardingEntity>(
  (ref) async {
    final client = ref.watch(gqlClientProvider).value;
    final userId = ref.watch(userProfileNotifierProvider).id;
    final onboardingData = ref
        .watch(onboardingRepositoryProvider)
        .getOnboardingData(client: client!, userId: userId!);
    onboardingData.then(
      (value) {
        ref.read(onBoardingStateNotifierProvider.notifier).updateFields(
              totalQuestions: value.totalQuestions,
              totalCompletedQuestions: value.totalCompletedQuestions,
              questions: value.questions,
            );
      },
    );
    return onboardingData;
  },
);

final onBoardingStateNotifierProvider =
    StateNotifierProvider<OnboardingStateNotifier, OnboardingEntity>(
  (ref) => OnboardingStateNotifier(
    OnboardingEntity(
      totalQuestions: 0,
      totalCompletedQuestions: 0,
      questions: [],
    ),
  ),
);

class OnboardingStateNotifier extends StateNotifier<OnboardingEntity> {
  OnboardingStateNotifier(OnboardingEntity state) : super(state);

  void updateFields({
    int? totalQuestions,
    int? totalCompletedQuestions,
    List<OnboardingQuestionEntity>? questions,
  }) {
    state = state.copyWith(
      totalQuestions: totalQuestions,
      totalCompletedQuestions: totalCompletedQuestions,
      questions: questions,
    );
  }

  // Future<void> getOnboardingData() async {
  //   final onboardingData = await fetchOnboardingData();
  //   state = onboardingData;
  // }

  // Future<void> finishOnboarding() async {
  //   // final onboardingData = await fetchOnboardingData();
  //   // state = onboardingData;
  // }
}

// typedef OnboardingCallback = Future<OnboardingEntity> Function();

// class OnboardingNotifier extends StateNotifier<OnboardingEntity> {
//   OnboardingCallback fetchOnboardingData;

//   OnboardingNotifier({
//     required this.fetchOnboardingData,
//   }) : super(state);

//   Future<void> getOnboardingData() async {
//     final onboardingData = await fetchOnboardingData();
//     state = onboardingData;
//   }
// }
 

// final startOnboardingQuestionsFutureProvider =
//     FutureProvider.autoDispose.family(
//   (ref, String idUser) async {
//     final gqlClient = ref.watch(gqlClientProvider).value;
//     if (gqlClient == null) {
//       throw Exception('GraphQL client is null');
//     }
//     print('id user ');
//     print(idUser);
//     final response = await gqlClient.mutate(
//       MutationOptions(
//         document: gql(
//           MutationRepository.startOnboardingQuestions(),
//         ),
//         variables: {
//           'user_id': idUser,
//         },
//       ),
//     );
//     print('response start onboarding!!!!!');
//     print(response);
//     final map_response = StartOnboardingMapper.fromJson(
//       response.data?['startOnboarding'],
//     );
//     final onboardingEntity = OnboardingEntity(
//       totalQuestions: map_response.totalQuestions ?? 0,
//       totalCompletedQuestions: map_response.questionsCompleted ?? 0,
//       questions: map_response.questions!
//           .map(
//             (e) => OnboardingQuestionEntity(
//               text: e.text ?? '',
//               uuid: e.uuid ?? '',
//               questionImageUrl: e.questionImageUrl ?? '',
//               answers: e.answers!
//                   .map(
//                     (e) => AnswerEntity(
//                       text: e.text ?? '',
//                       uuid: e.uuid ?? '',
//                       value: e.value ?? 0,
//                     ),
//                   )
//                   .toList(),
//               value: '',
//             ),
//           )
//           .toList(),
//     );
//   },
// );

// final finishOnboardingQuestions = FutureProvider.family(
//   (ref, arg) {
//     return Future.value({});
//   },
// );
