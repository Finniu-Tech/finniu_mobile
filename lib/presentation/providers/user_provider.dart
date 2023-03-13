import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileFutureProvider =
    FutureProvider.autoDispose<UserProfile>((ref) async {
  final result = await ref.watch(gqlClientProvider.future).then(
    (client) async {
      final QueryResult result = await client.query(
        QueryOptions(
          document: gql(
            QueryRepository.getUserProfile,
          ), // this is the query string you just created
          pollInterval: const Duration(seconds: 10),
        ),
      );
      return result;
    },
  );
  print('result user profile');
  print(result);
  if (result.hasException) {
    throw result.exception!;
  }
  if (result.data?['userProfile'] != null) {
    final userProfile = UserProfile.fromJson(result.data?['userProfile']);
    ref.read(hasCompletedOnboardingProvider.notifier).state =
        userProfile.hasCompletedOnboarding ?? false;
    ref.read(userProfileNotifierProvider.notifier).updateFields(
          id: userProfile.uuid,
          nickName: userProfile.nickName,
          email: userProfile.email,
          firstName: userProfile.firstName,
          lastName: userProfile.lastName,
          phoneNumber: userProfile.phoneNumber,
          imageProfileUrl: userProfile.imageProfileUrl,
          hasCompletedOnboarding: userProfile.hasCompletedOnboarding ?? false,
        );
    return userProfile;
  }
  return UserProfile();
});

final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileStateNotifierProvider, UserProfile>(
  (ref) => UserProfileStateNotifierProvider(UserProfile()),
);

class UserProfileStateNotifierProvider extends StateNotifier<UserProfile> {
  UserProfileStateNotifierProvider(UserProfile user) : super(user);

  void updateFields({
    String? id,
    String? nickName,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? password,
    String? imageProfileUrl,
    bool hasCompletedOnboarding = false,
  }) {
    state = state.copyWith(
      id: id,
      nickName: nickName,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      hasCompletedOnboarding: hasCompletedOnboarding,
      password: password,
      imageProfileUrl: imageProfileUrl,
    );
  }

  // existing set methods

  void setNickName(String? nickName) {
    state = state.copyWith(nickName: nickName);
  }

  void setEmail(String? email) {
    state = state.copyWith(email: email);
  }

  void setFirstName(String? firstName) {
    state = state.copyWith(firstName: firstName);
  }

  void setLastName(String? lastName) {
    state = state.copyWith(lastName: lastName);
  }

  void setPhone(String? phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void setOnboardingCompleted(bool hasCompletedOnboarding) {
    state = state.copyWith(hasCompletedOnboarding: hasCompletedOnboarding);
  }

  void setPassword(String? password) {
    state = state.copyWith(password: password);
  }
}

final hasCompletedOnboardingProvider = StateProvider((ref) => false);
