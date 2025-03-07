import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/otp_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:finniu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SendCode extends ConsumerWidget {
  const SendCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    final userProfileProvider = ref.watch(userProfileNotifierProvider);
    final graphQLClient = ref.watch(gqlClientProvider);

    return CustomLoaderOverlay(
      child: CustomScaffoldReturn(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              SizedBox(
                width: 291,
                height: 71,
                child: TextPoppins(
                  text: "Tu seguridad es primero",
                  colorText:
                      themeProvider.isDarkMode ? primaryLight : primaryDark,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const SizedBox(
                width: 118,
                height: 95.62,
                child: Image(
                  image: AssetImage('assets/sendcode/send_code.png'),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: 280,
                height: 60,
                child: Text(
                  textAlign: TextAlign.center,
                  'Te enviaremos el código de verificación por correo',
                  style: TextStyle(
                    fontSize: 14,
                    color: themeProvider.isDarkMode
                        ? const Color(whiteText)
                        : const Color(primaryDark),
                  ),
                ),
              ),
              SizedBox(
                width: 224,
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    context.loaderOverlay.show();

                    graphQLClient.when(
                      data: (client) async {
                        final result = await sendEmailOTPCode(
                          userProfileProvider.email!,
                          client,
                        );

                        if (result == true) {
                          context.loaderOverlay.hide();
                          Navigator.of(context).pushNamed('/activate_account');
                        } else {
                          showSnackBarV2(
                            context: context,
                            title: "Error al enviar el correo",
                            message: 'No se pudo enviar el correo',
                            snackType: SnackType.error,
                          );
                        }
                      },
                      loading: () => null,
                      error: (error, stackTrace) => null,
                    );
                  },
                  child: const Text(
                    'Recibir Código',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 65,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
