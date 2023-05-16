import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final userProfile = ref.watch(userProfileNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    return CustomScaffoldReturnLogo(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
            // ),
            Row(
              children: [
                SizedBox(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Notificaciones',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: currentTheme.isDarkMode
                            ? const Color(0xffA2E6FA)
                            : const Color(primaryDark),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: Image.asset('assets/home/notification.png'),
                  ),
                ),
              ],
            ),
            // const Expanded(
            //   child: SizedBox.shrink(),
            // ),

            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Hoy',
                style: TextStyle(
                  fontSize: 16,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(primaryDark),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              alignment: Alignment.center,
              width: 320.0,
              height: 122.0,
              decoration: BoxDecoration(
                color: Color(primaryLight),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '${userProfile.nickName}, bienvenida a Finniu comienza a vivir financieramente estable desde hoy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
