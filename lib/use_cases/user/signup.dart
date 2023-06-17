import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/presentation/providers/signup_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';

class SignUpService {
  void updatePhone(ref, String phone) {
    ref.read(userProfileNotifierProvider.notifier).setPhone(phone);
  }

  Future<bool> finishRegister(ref, phone) async {
    updatePhone(ref, phone);
    final userProfile = ref.watch(userProfileNotifierProvider);
    final userInput = RegisterUserModel(
      nickname: userProfile.nickName!,
      email: userProfile.email!,
      password: userProfile.password!,
      phone: int.parse(userProfile.phoneNumber!),
    );
    final status = await ref.watch(registerMutationProvider(userInput).future);

    return status;
  }
}
