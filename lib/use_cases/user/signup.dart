import 'package:finniu/infrastructure/models/auth.dart';
import 'package:finniu/presentation/providers/signup_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';

class SignUpService {
  void updatePhone(ref, String phone) {
    ref.read(userProfileNotifierProvider.notifier).setPhone(phone);
  }

  Future<bool> finishRegister(ref, phone) async {
    print('start finish register');
    updatePhone(ref, phone);
    print('passupdate');
    final userProfile = ref.watch(userProfileNotifierProvider);
    print('passuserprofile');
    print(userProfile);
    final userInput = RegisterUserModel(
      nickname: userProfile.nickName!,
      email: userProfile.email!,
      password: userProfile.password!,
      phone: int.parse(userProfile.phoneNumber!),
    );
    final status = await ref.watch(registerMutationProvider(userInput).future);

    print('passstatus');
    return status;
  }
}
