import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/user_profile_datasource_imp.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileFutureProvider = FutureProvider.autoDispose<UserProfile>((ref) async {
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

  if (result.data?['userProfile'] != null) {
    final userProfile = UserProfile.fromJson(result.data?['userProfile']);
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
          address: userProfile.address,
          occupation: userProfile.occupation,
        );
    return userProfile;
  }
  return UserProfile();
});

final updateUserProfileFutureProvider =
    FutureProvider.autoDispose.family<bool, UserProfile>((ref, UserProfile userProfile) async {
  final success = await UserProfileDataSourceImp().update(
    client: await ref.watch(gqlClientProvider.future),
    userProfile: userProfile,
  );
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
          hasCompletedOnboarding: userProfile.hasCompletedOnboarding ?? false,
          address: userProfile.address,
          occupation: userProfile.occupation,
        );
  }
  return success;
});

final userProfileNotifierProvider = StateNotifierProvider<UserProfileStateNotifierProvider, UserProfile>(
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
    String? address,
    String? occupation,
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
      documentNumber: documentNumber,
      distrito: distrito,
      provincia: provincia,
      region: region,
      civilStatus: civilStatus,
      address: address,
      occupation: occupation,
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

  void setOcupation(String? occupation) {
    state = state.copyWith(occupation: occupation);
  }
}
