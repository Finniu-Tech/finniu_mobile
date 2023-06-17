import 'dart:convert';
import 'package:finniu/constants/avatars.dart';
import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/infrastructure/models/user.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final registerMutationProvider = FutureProvider.family(
  (ref, RegisterUserModel userInputData) async {
    final gqlClient = ref.watch(gqlClientProvider).value;
    if (gqlClient == null) {
      throw Exception('GraphQL client is null');
    }

    String avatarImage =
        await base64ImageFromIndex(ref.watch(indexAvatarSelectedStateProvider));

    final response = await gqlClient.mutate(
      MutationOptions(
        document: gql(
          MutationRepository.getSignUpMutation(),
        ),
        variables: {
          'image': avatarImage,
          'nickname': userInputData.nickname,
          'email': userInputData.email,
          'password': userInputData.password,
          'phone': userInputData.phone,
        },
      ),
    );
    if (response.data == null) {
      return false;
    }
    final registerResponse =
        RegisterUser.fromJson(response.data?['registerUser']);
    final userResponse = registerResponse.user?.userProfile;

    if (userResponse != null) {
      ref.read(userProfileNotifierProvider.notifier).updateFields(
            nickName: userResponse.nickName,
            email: userResponse.email,
            firstName: userResponse.firstName,
            lastName: userResponse.lastName,
            phoneNumber: userResponse.phoneNumber,
          );
    }

    return registerResponse.success;
  },
);

final indexAvatarSelectedStateProvider = StateProvider((ref) => 0);

Future<String> base64ImageFromIndex(int index) async {
  String pathAvatar = listAvatars[index];
  ByteData bytes = await rootBundle.load(pathAvatar);
  var buffer = bytes.buffer;
  return 'data:image/png;base64,' + base64.encode(Uint8List.view(buffer));
}
