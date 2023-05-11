import 'package:finniu/presentation/providers/auth_provider.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';

void logout(ref) {
  ref.invalidate(authTokenProvider);
  ref.invalidate(gqlClientProvider);
  ref.invalidate(userProfileFutureProvider);
  ref.invalidate(bankFutureProvider);
  ref.invalidate(deadLineFutureProvider);
}
