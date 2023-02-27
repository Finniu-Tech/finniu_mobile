import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final Provider<String> authTokenProvider = StateProvider<String>((ref) {
//   return '';
// });

final authTokenProvider = StateProvider<String>((ref) {
  return '';
});

final gqlClientProvider = Provider<ValueNotifier<GraphQLClient>>((ref) {
  // final String token = ref.watch(authTokenProvider);

  // final HttpLink httpLink = HttpLink(
  //   'https://finniu.com/api/v1/graph/finniu/',
  // );

  final HttpLink httpLink = HttpLink(
    'https://finniu.com/api/v1/graph/finniu/',
    // defaultHeaders: {'Authorization': token != '' ? 'JWT $token' : 'Bearer'}
    // defaultHeaders: {if (token.isNotEmpty) 'JWT': token},
  );
  String token = ref.read(authTokenProvider);
  final authLink = AuthLink(getToken: () async => 'JWT ${token}');
  final link = authLink.concat(httpLink);

  print('httpLink:');
  // print(httpLink.defaultHeaders);
  // final _webSocketLink = WebSocketLink('ws://10.0.2.2:4200/graphql');
  // var link = Link.split(
  //   (request) => request.isSubscription,
  //   httpLink,
  // );

  // print('token is not empty: $token.isNotEmpty');

  // final AuthLink authLink = AuthLink(
  //   getToken: () async => token != '' ? 'JWT $token' : 'Bearer',
  //   // OR
  //   // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  // );

  // final AuthLink authLink = AuthLink(getToken: )
  // final Link link = authLink.concat(httpLink);
  // print('link: $link.toString()');

  return ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
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
