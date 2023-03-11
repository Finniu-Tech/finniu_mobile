import 'package:finniu/graphql/mutations.dart';
import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authTokenProvider = StateProvider<String>((ref) => '');

final authTokenMutationProvider =
    FutureProvider.autoDispose.family<String?, LoginModel>((ref, login) async {
  final gqlClient = ref.watch(gqlClientProvider).value;
  if (gqlClient == null) {
    throw Exception('GraphQL client is null');
  }

  final userData = await gqlClient.mutate(
    MutationOptions(
      document: gql(
        MutationRepository.getAuthTokenMutation(),
      ),
      variables: {
        'email': login.email,
        'password': login.password,
      },
    ),
  );

  return userData.data?['tokenAuth']['token'];
});

class UserProvider extends ChangeNotifier {
  late String? _nickName;
  late String? _email;
  late String? _firstName;
  late String? _lastName;
  late int? _phone;
  late bool _onboardingCompleted;

  UserProvider({
    nickName,
    email,
    firstName,
    lastName,
    phone,
  }) {
    _nickName = nickName;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
  }
  String? get nickName => _nickName;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  int? get phone => _phone;
  bool get onboardingCompleted => _onboardingCompleted;

  set nickName(String? nickName) {
    _nickName = nickName;
    notifyListeners();
  }

  set email(String? email) {
    _email = email;
    notifyListeners();
  }

  set firstName(String? firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  set lastName(String? lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  set phone(int? phone) {
    _phone = phone;
    notifyListeners();
  }

  set onboardingCompleted(bool onboardingCompleted) {
    _onboardingCompleted = onboardingCompleted;
    notifyListeners();
  }
}
