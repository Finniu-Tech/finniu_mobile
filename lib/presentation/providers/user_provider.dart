import 'package:finniu/domain/entities/user_profile_completeness.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/user_profile_datasource_imp.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/onboarding_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final seeLaterProvider = StateProvider<bool>((ref) {
  return false;
});

final userProfileFutureProvider =
    FutureProvider.autoDispose<UserProfile>((ref) async {
  try {
    final result = await ref.watch(gqlClientProvider.future).then(
      (client) async {
        final QueryResult result = await client.query(
          QueryOptions(
            document: gql(
              QueryRepository.getUserProfile,
            ),
            fetchPolicy: FetchPolicy.noCache,
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
            percentCompleteProfile: userProfile.percentCompleteProfile,
            hasCompletedTour: userProfile.hasCompletedTour,
            lastNameFather: userProfile.lastNameFather,
            lastNameMother: userProfile.lastNameMother,
            countryPrefix: userProfile.countryPrefix,
            documentType: userProfile.documentType,
            gender: userProfile.gender ?? "OTHER",
            houseNumber: userProfile.houseNumber,
            postalCode: userProfile.postalCode,
            laborSituation: userProfile.laborSituation,
            companyName: userProfile.companyName,
            serviceTime: userProfile.serviceTime,
            biography: userProfile.biography,
            facebook: userProfile.facebook,
            instagram: userProfile.instagram,
            linkedin: userProfile.linkedin,
            isDirectorOrShareholder10Percent:
                userProfile.isDirectorOrShareholder10Percent,
            isPublicOfficialOrFamily: userProfile.isPublicOfficialOrFamily,
            acceptPrivacyPolicy: userProfile.acceptPrivacyPolicy,
            acceptTermsConditions: userProfile.acceptTermsConditions,
            birthDate: userProfile.birthDate,
          );
      return userProfile;
    }
    return UserProfile();
  } catch (e) {
    return UserProfile();
  }
});

final updateUserProfileFutureProvider = FutureProvider.autoDispose
    .family<bool, UserProfile>((ref, UserProfile userProfile) async {
  final resp = await UserProfileDataSourceImp().update(
    client: await ref.watch(gqlClientProvider.future),
    userProfile: userProfile,
  );
  final success = resp['success'];
  final percentaje = resp['percentCompleteProfile'] != null
      ? double.parse(resp['percentCompleteProfile'].toString())
      : 0.0;
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
          percentCompleteProfile: percentaje,
          hasCompletedTour: userProfile.hasCompletedTour,
          lastNameFather: userProfile.lastNameFather,
          lastNameMother: userProfile.lastNameMother,
          countryPrefix: userProfile.countryPrefix,
          documentType: userProfile.documentType,
          gender: userProfile.gender,
          houseNumber: userProfile.houseNumber,
          postalCode: userProfile.postalCode,
          laborSituation: userProfile.laborSituation,
          companyName: userProfile.companyName,
          serviceTime: userProfile.serviceTime,
          biography: userProfile.biography,
          facebook: userProfile.facebook,
          instagram: userProfile.instagram,
          linkedin: userProfile.linkedin,
          isDirectorOrShareholder10Percent:
              userProfile.isDirectorOrShareholder10Percent,
          isPublicOfficialOrFamily: userProfile.isPublicOfficialOrFamily,
          acceptPrivacyPolicy: userProfile.acceptPrivacyPolicy,
          acceptTermsConditions: userProfile.acceptTermsConditions,
          birthDate: userProfile.birthDate,
        );
  }
  return success;
});

final updateUserAvatarFutureProvider = FutureProvider.autoDispose
    .family<bool, String>((ref, String imageProfileUrl) async {
  final response = await UserProfileDataSourceImp().updateAvatar(
    client: await ref.watch(gqlClientProvider.future),
    imageProfile: imageProfileUrl,
  );
  if (response!.isNotEmpty) {
    ref.read(userProfileNotifierProvider.notifier).updateFields(
          imageProfileUrl: response,
        );
    return true;
  }
  return false;
});

final reloadUserProfileFutureProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  try {
    final client = await ref.watch(gqlClientProvider.future);
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(QueryRepository.getUserProfile),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    if (result.hasException || result.data == null) {
      return false;
    }

    final userProfile = UserProfile.fromJson(result.data?['userProfile']);

    if (userProfile.hasCompletedOnboarding == true) {
      ref.read(hasCompletedOnboardingProvider.notifier).state = true;
    }
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
          percentCompleteProfile: userProfile.percentCompleteProfile,
          hasCompletedTour: userProfile.hasCompletedTour,
          lastNameFather: userProfile.lastNameFather,
          lastNameMother: userProfile.lastNameMother,
          countryPrefix: userProfile.countryPrefix,
          documentType: userProfile.documentType,
          gender: userProfile.gender,
          houseNumber: userProfile.houseNumber,
          postalCode: userProfile.postalCode,
          laborSituation: userProfile.laborSituation,
          companyName: userProfile.companyName,
          serviceTime: userProfile.serviceTime,
          biography: userProfile.biography,
          facebook: userProfile.facebook,
          instagram: userProfile.instagram,
          linkedin: userProfile.linkedin,
          isDirectorOrShareholder10Percent:
              userProfile.isDirectorOrShareholder10Percent,
          isPublicOfficialOrFamily: userProfile.isPublicOfficialOrFamily,
          acceptPrivacyPolicy: userProfile.acceptPrivacyPolicy,
          acceptTermsConditions: userProfile.acceptTermsConditions,
          birthDate: userProfile.birthDate,
        );

    return true;
  } catch (e) {
    return false;
  }
});

final userProfileNotifierProvider =
    StateNotifierProvider<UserProfileStateNotifierProvider, UserProfile>(
  (ref) => UserProfileStateNotifierProvider(UserProfile()),
);

class UserProfileStateNotifierProvider extends StateNotifier<UserProfile> {
  UserProfileStateNotifierProvider(super.user);

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
    double? percentCompleteProfile,
    bool? hasCompletedTour,
    bool? hasSeeLaterTour,
    String? lastNameFather,
    String? lastNameMother,
    String? countryPrefix,
    String? documentType,
    String? gender,
    String? houseNumber,
    String? postalCode,
    String? laborSituation,
    String? companyName,
    String? serviceTime,
    String? biography,
    String? facebook,
    String? instagram,
    String? linkedin,
    bool? isDirectorOrShareholder10Percent,
    bool? isPublicOfficialOrFamily,
    bool? acceptPrivacyPolicy,
    bool? acceptTermsConditions,
    String? birthDate,
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
      percentCompleteProfile: percentCompleteProfile,
      hasCompletedTour: hasCompletedTour,
      lastNameFather: lastNameFather,
      lastNameMother: lastNameMother,
      countryPrefix: countryPrefix,
      documentType: documentType,
      gender: gender,
      houseNumber: houseNumber,
      postalCode: postalCode,
      laborSituation: laborSituation,
      companyName: companyName,
      serviceTime: serviceTime,
      biography: biography,
      facebook: facebook,
      instagram: instagram,
      linkedin: linkedin,
      isDirectorOrShareholder10Percent: isDirectorOrShareholder10Percent,
      isPublicOfficialOrFamily: isPublicOfficialOrFamily,
      acceptPrivacyPolicy: acceptPrivacyPolicy,
      acceptTermsConditions: acceptTermsConditions,
      birthDate: birthDate,
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

final userProfileCompletenessProvider =
    FutureProvider.autoDispose<UserProfileCompleteness>((ref) async {
  final client = await ref.watch(gqlClientProvider.future);
  final dataSource = UserProfileDataSourceImp();

  try {
    final resp = await dataSource.getUserProfileCompleteness(client: client);
    return resp;
  } catch (e) {
    throw e;
  }
});
