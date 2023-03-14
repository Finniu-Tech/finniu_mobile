import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/recovery_password_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final recoveryPasswordFutureProvider =
    FutureProvider.autoDispose.family<bool, String>(
  (ref, email) async {
    final recoveryPasswordRepository =
        ref.read(recoveryPasswordRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    return await recoveryPasswordRepository.sendEmailRecoveryPassword(
      client: client!,
      email: email,
    );
  },
);
