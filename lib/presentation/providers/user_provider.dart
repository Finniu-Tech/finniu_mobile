import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/user_profile_datasource_imp.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
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
          ),
          pollInterval: const Duration(seconds: 10),
        ),
      );
      return result;
    },
  );
  print('result user profile');
  print(result);
  // if (result.hasException) {
  //   throw result.exception!;
  // }
  print('before if');
  if (result.data?['userProfile'] != null) {
    print('entre if ');
    final userProfile = UserProfile.fromJson(result.data?['userProfile']);
    print('user profile zero!!!!!');
    print(userProfile.documentNumber);
    if (userProfile.hasCompletedOnboarding == true) {
      ref.read(hasCompletedOnboardingProvider.notifier).state = true;
    }
    // ref.read(hasCompletedOnboardingProvider.notifier).state =
    //     userProfile.hasCompletedOnboarding ?? false;
    ref.read(userProfileNotifierProvider.notifier).updateFields(
          id: userProfile.uuid,
          nickName: userProfile.nickName,
          email: userProfile.email,
          firstName: userProfile.firstName,
          lastName: userProfile.lastName,
          phoneNumber: userProfile.phoneNumber,
          documentNumber: userProfile.documentNumber,
          imageProfileUrl: userProfile.imageProfileUrl,
          hasCompletedOnboarding: userProfile.hasCompletedOnboarding ?? false,
          distrito: userProfile.distrito,
          provincia: userProfile.provincia,
          region: userProfile.region,
          civilStatus: userProfile.civilStatus,
        );
    return userProfile;
  }
  return UserProfile();
});

final updateUserProfileFutureProvider = FutureProvider.autoDispose
    .family<bool, UserProfile>((ref, UserProfile userProfile) async {
  final success = await UserProfileDataSourceImp().update(
    client: await ref.watch(gqlClientProvider.future),
    userProfile: userProfile,
  );
  print('result update user profile');
  print(success);
  if (success == true) {
    ref.read(userProfileNotifierProvider.notifier).updateFields(
          id: userProfile.uuid,
          nickName: userProfile.nickName,
          email: userProfile.email,
          firstName: userProfile.firstName,
          lastName: userProfile.lastName,
          phoneNumber: userProfile.phoneNumber,
          imageProfileUrl: userProfile.imageProfileUrl,
          documentNumber: userProfile.documentNumber,
          distrito: userProfile.distrito,
          provincia: userProfile.provincia,
          region: userProfile.region,
          civilStatus: userProfile.civilStatus,
        );
  }
  return success;
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
    String? documentNumber,
    String? distrito,
    String? provincia,
    String? region,
    String? civilStatus,
    bool hasCompletedOnboarding = false,
  }) {
    print('update fields user profile +++++++');
    print('documentNumber');
    print(documentNumber);
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
      documentNumber: documentNumber,
      distrito: distrito,
      provincia: provincia,
      region: region,
      civilStatus: civilStatus,
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
